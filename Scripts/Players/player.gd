extends CharacterBody2D

const LEFT_BORDER = 150
const RIGHT_BORDER = 810
const CENTER = Vector2(480, 270)
const TOP = Vector2(480, -100)
const SPEED = 100.0

@onready var laser_1 = $"Laser 1"
@onready var laser_2 = $"Laser 2"

@onready var player_anim = $AnimatedSprite2D

var hp = 3
signal hp_changed
signal death
signal hp_at_2
signal hp_at_1

# Basic movement
func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position().x
	if mouse_pos > LEFT_BORDER and mouse_pos < RIGHT_BORDER:
		position.x = get_global_mouse_position().x
	elif abs(mouse_pos - LEFT_BORDER) < abs(mouse_pos - RIGHT_BORDER):
		position.x = LEFT_BORDER
	else:
		position.x = RIGHT_BORDER

func _process(_delta):
	pass

# Idle animation upon entering the scene
func _ready():
	player_anim.play("idle")

func take_damage(dmg):
	set_hp(hp - dmg)

func set_hp(new_hp):
	hp = new_hp
	print(hp)
	emit_signal("hp_changed")
	if hp <= 0:
		die()
	elif hp == 2:
		emit_signal("hp_at_2")
	elif hp == 1:
		emit_signal("hp_at_1")

func die():
	emit_signal("death")
	queue_free()
	
# Collision detection with enemy
func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") or area.is_in_group("Asteroid"):
		take_damage(1)
