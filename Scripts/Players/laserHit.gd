extends RayCast2D

@onready var laser_1 = $"."

var is_casting: bool = false
var cast_timer: Timer
var has_collided = false
var collision_point: Vector2

func _ready():
	is_casting = false

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
			laser_1.get_collider().queue_free()
			print("Hit")
			has_collided = true
		else:
			print("Miss!")
			

	if Input.is_action_pressed("ui_left"):
		appear()
	else:
		disapear()

func update_line() -> void:
	if is_colliding() and not has_collided:
		collision_point = to_local(get_collision_point())
		if laser_1.get_collider() != null:
			laser_1.get_collider().queue_free()
			has_collided = true
			AudioPlayer.hit() # This works
			print("Hit")

func appear() -> void:
	pass

func disapear() -> void:
	has_collided = false
