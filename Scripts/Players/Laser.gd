extends RayCast2D

@onready var laser_1 = $"."

# TODO bug fixes

# TODO Particles
# @onready var casting_particles: GPUParticles2D = $CastingParticles
# @onready var collision_particles_2: GPUParticles2D = $CollisionParticles2
# @onready var beam_particle_2d: GPUParticles2D = $BeamParticle2D

var is_casting: bool = false
var cast_timer: Timer
var has_collided = false
var collision_point: Vector2

func _ready():
	is_casting = false
	cast_timer = Timer.new()
	add_child(cast_timer)
	cast_timer.connect("timeout", _on_cast_timer_timeout, 0)
	$Line2D.width = 0  # Set initial width to 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		self.is_casting = event.pressed

func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()

	if is_colliding() and is_casting and not has_collided:
		cast_point = to_local(get_collision_point())
		collision_point = to_local(get_collision_point())
		var collisions = []
		collisions.append(laser_1.get_collider())
		# If guns collided,
		if collisions.size() > 0:
			for collision in collisions:
				# Remove the collided object from the scene
				collision.queue_free()
			print("Hit")
			has_collided = true
		else:
			print("Miss!")
			
		# TODO
		# collision_particles_2.global_rotation = get_collision_normal().angle()
		# collision_particles_2.position = cast_point

	if has_collided:
		$Line2D.points[1] = collision_point
	else:
		$Line2D.points[1] = cast_point
	# TODO
	# beam_particle_2d.position = cast_point * 0.5
	# beam_particle_2d.process_material.emission_box_extents.x = cast_point.length() * 0.5

	if is_casting:
		appear()

func appear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 3.0, 0.2)
	cast_timer.start(0.05)  # Adjust the duration as needed

func _on_cast_timer_timeout():
	disapear()

func disapear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.01)
	has_collided = false
