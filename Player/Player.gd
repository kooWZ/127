extends KinematicBody2D

const max_speed := 500
const acceleration := 100.0
const air_acceleration := max_speed / 0.2
const jump_force := 900

export var velocity := Vector2.ZERO
export var gravrity := 2000 / 60		# 除以 60 相当于乘以 _physics_process() 的 delta
onready var sprite = $Sprite

onready var coyote_timer = $CoyoteTimer
onready var animation_player = $AnimationPlayer
onready var jump_request_timer = $JumpRequestTimer

var is_jumping := false


func _ready():
	var tween := create_tween()
	tween.set_loops()
	tween.tween_callback(self, "change_frame")
	tween.tween_interval(0.3)
	pass


func change_frame():
	sprite.frame = 1 ^ sprite.frame


func _input(event):
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
		
	if event.is_action_released("jump") and velocity.y < -jump_force / 2.5:
		velocity.y = -jump_force / 2.5


func request_jump():
	var can_jump: bool = is_on_floor() or coyote_timer.time_left > 0
	if can_jump:
		velocity.y = -jump_force
		is_jumping = true
		coyote_timer.stop()
		jump_request_timer.stop()


func _physics_process(_delta):
	var was_on_floor := is_on_floor()
	
	try_to_move()
	
	if is_on_floor():
		is_jumping = false
	elif was_on_floor and not is_jumping:
		coyote_timer.start()
	if jump_request_timer.time_left > 0:
		request_jump()
	
	update_sprite_and_animation()


func try_to_move() -> void:
	var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var acc: float = acceleration if is_on_floor() else air_acceleration
	velocity.x = move_toward(velocity.x, direction * max_speed, acc)
	velocity.y += gravrity
	velocity = move_and_slide(velocity, Vector2.UP)


func update_sprite_and_animation() -> void:
	if is_jumping:
		if animation_player.current_animation != "Jumping" or not animation_player.is_playing():
			animation_player.play("Jump")
	elif velocity.x == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Walk")
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0


func _on_Hurtbox_hurt(hitbox: Hitbox):
	if hitbox.attack_type == "code":
		queue_free()
	if hitbox.attack_type != "patrolman":
		return
#	get_tree().reload_current_scene()
	


func _on_Hitbox_hit():
#	velocity.y = -jump_force / 2.0
	is_jumping = true
