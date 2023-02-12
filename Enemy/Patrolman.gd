extends Node2D

export(float) var max_speed = 100.0
export(float) var acceleration = 20.0

onready var line_2d = $Line2D
onready var path_2d = $Path2D
onready var path_follow_2d = $Path2D/PathFollow2D
onready var enemy = $Enemy
onready var sprite = $Enemy/Sprite
onready var sensor = $Enemy/Sensor
onready var animation_player = $Enemy/AnimationPlayer
onready var remote_transform_2d = $Path2D/PathFollow2D/RemoteTransform2D

var patrol_curve: Curve2D
var patrol_tween: SceneTreeTween
var original_node_path: NodePath
var pause_position := Vector2.ZERO
var velocity := Vector2.ZERO

var detected := false
var patroling := true
var is_dead := false

func _ready():
	
	animation_player.play("Idle")
	patrol_curve = path_2d.curve
	for i in patrol_curve.get_point_count():
		line_2d.add_point(patrol_curve.get_point_position(i))
	line_2d.hide()
	
	patrol_tween = create_tween()
	patrol_tween.set_loops()
	patrol_tween.tween_property(path_follow_2d, "unit_offset", 1.0, patrol_curve.get_baked_length() / max_speed).from(0.0)
	patrol_tween.tween_property(path_follow_2d, "unit_offset", 0.0, patrol_curve.get_baked_length() / max_speed).from(1.0)
	
	path_follow_2d.unit_offset = 0.5


func _physics_process(_delta):
	if is_dead:
		return
	velocity = enemy.move_and_slide(velocity)


func _process(_delta):
	
	enemy.rotation_degrees = 0
	if is_dead:
		return
	
	if not patroling:
		var target_position: Vector2
		if detected:
			target_position = sensor.get_overlapping_bodies()[0].position
		else:
			# get_closest_point() 函数是一坨
#			target_position = patrol_curve.get_closest_point(position)
			target_position = pause_position
#		draw_position(target_position)
		# 我是傻逼, 不是 position, 是 enemy.position. 不是 enemy.position, 是 enemy.global_position
		velocity = velocity.move_toward(enemy.global_position.direction_to(target_position) * max_speed, acceleration)
		
		if enemy.global_position.distance_squared_to(target_position) < 25:
			patroling = true
			recover_patrol()
#			remote_transform_2d.remote_path = original_node_path



func draw_position(v: Vector2):
	var s = Sprite.new()
	s.texture = preload("res://Asset/PNG/Tiles/platformPack_tile011.png")
	s.position = v
	s.scale = Vector2(0.3, 0.3)
	get_parent().add_child(s)
	pass

func show_route():
	line_2d.show()


func hide_route():
	line_2d.hide()


func pause_patrol() -> void:
	patrol_tween.pause()


func recover_patrol() -> void:
	patrol_tween.play()


func _on_Sensor_body_entered(_player):
#	original_node_path = remote_transform_2d.remote_path
#	remote_transform_2d.remote_path = ""
	if detected:
		return
	animation_player.play("Active")
	detected = true
	patroling = false
	pause_patrol()
	pause_position = enemy.global_position


func _on_Sensor_body_exited(_player):
	animation_player.play("Idle")
	detected = false
#	patroling = true
#	recover_patrol()

#
#func set_circle_shape(v: CircleShape2D) -> void:
#	var sprite := preload("res://Asset/PNG/Tiles/platformPack_tile044.png")
#	sprite.modulate.a = 0.4
#	self.shape = v
#
#
#func set_rect_shape(v: RectangleShape2D) -> void:
#	var sprite := preload("res://Asset/PNG/Tiles/platformPack_tile044.png")
#	sprite.modulate.a = 0.4
#	self.shape = v
#
#func set_shape(v: Shape2D) -> void:
#	shape = v


func rebulid() -> void:
#	print_debug("patrolman 复活函数未完成")
	sprite.show()
	is_dead = false
	sprite.material = null
	pass

func _on_Hurtbox_hurt(hitbox):
#	print_debug("patrolman 受伤函数未完成")
	is_dead = true
	sprite.material = Global.blinking_tile_shader_material
	var t := create_tween()
	t.tween_interval(1)
	t.tween_callback(sprite, "hide")
	pass # Replace with function body.
