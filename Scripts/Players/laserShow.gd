extends RayCast2D

@onready var laser_1 = $"."

var is_casting: bool = false
var cast_timer: Timer
var has_collided = false
var collision_point: Vector2

func _ready():
	is_casting = false
	$Line2D.width = 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			# self.is_casting = event.pressed
			AudioPlayer.shoot()
			update_line()

func _physics_process(_delta: float) -> void:
	var _cast_point := target_position
	force_raycast_update()
		
	if is_colliding() and Input.is_action_pressed("ui_left") and not has_collided:
		collision_point = to_local(get_collision_point())
		if laser_1.get_collider() != null:
			# laser_1.get_collider().queue_free()
			print("Hit")
			has_collided = true
		else:
			print("Miss!")
			
		# TODO
		# collision_particles_2.global_rotation = get_collision_normal().angle()
		# collision_particles_2.position = cast_point
		
	# TODO
	# beam_particle_2d.position = cast_point * 0.5
	# beam_particle_2d.process_material.emission_box_extents.x = cast_point.length() * 0.5

	if Input.is_action_pressed("ui_left"):
		appear()
	else:
		disapear()

func update_line() -> void:
	if is_colliding() and not has_collided:
		collision_point = to_local(get_collision_point())
		if laser_1.get_collider() != null:
			# laser_1.get_collider().queue_free()
			has_collided = true
			AudioPlayer.hit() # This works
			$Line2D.points[1] = collision_point
			print("Hit")
	else:
		$Line2D.points[1] = target_position
	appear()

func appear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 3.0, 0.01)

func disapear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.05)
	has_collided = false
