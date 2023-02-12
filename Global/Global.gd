extends Node

signal say(id)
signal saymany(arr)

const bgm_idx = 1
const sfx_idx = 2
const debug= true
const SAVE_PATH := "user://data.sav"
var blinking_tile_shader_material= ShaderMaterial.new()
onready var bgm = $BGM
var first_time_open = true
# 应该用 flag,  我是 sb
var first_meet_enemy:= true
var first_meet_patrolman:= true
var first_meet_surveillant:= true
var first_meet_watch_dog:= true
var paused_by_dialogs := false


onready var color_rect = $CanvasLayer/ColorRect
onready var animation_player = $AnimationPlayer

func _input(event):
	if event.is_action_pressed("restart"):
		animation_player.play("fade-in")
		get_tree().reload_current_scene()

func _ready():
	color_rect.hide()
	blinking_tile_shader_material.shader = preload("res://Shader/BlinkingTile.shader")

func save_game():
	var file := File.new()
	if file.open(SAVE_PATH, File.WRITE) != OK:
		return
	var data := {
		inventory=Inventory.to_dict(),
		flag=Flag.to_dict(),
		current_scene=get_tree().current_scene.filename.get_file().get_basename(),
	}
	var json := to_json(data)
	file.store_string(json)


func load_game():
	var file := File.new()
	if file.open(SAVE_PATH, File.READ) != OK:
		return
	var json := file.get_as_text()
	var data := parse_json(json) as Dictionary
	Inventory.from_dict(data.inventory)
	Flag.from_dict(data.Flag)
	change_scene("res://World/%s.tscn" % data.current_scene)


func new_game():
	Inventory.reset()
	Flag.reset()
	print_debug("new game 函数未设置")
#	change_scene("res://scene/H1.tscn")


func has_save_file() -> bool:
	return File.new().file_exists(SAVE_PATH)


func switchover_bgm() -> void:
	AudioServer.set_bus_mute(bgm_idx, !AudioServer.is_bus_mute(bgm_idx))


func switchover_sfx() :
	AudioServer.set_bus_mute(sfx_idx, !AudioServer.is_bus_mute(sfx_idx))

func get_sfx_mute():
	return AudioServer.is_bus_mute(sfx_idx)


func play_bgm(path) -> void:
	bgm.stream = load(path)
	bgm.play()

func change_scene(path: String) -> void:
	animation_player.play("fade-in")
	get_tree().change_scene(path)

func pause_with_bgm():
	get_tree().current_scene.get_node("BGM").pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().current_scene.get_node("CanvasLayer/DialogHUD").pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	paused_by_dialogs = true
	
func resume_with_bgm():
	get_tree().paused = false
	get_tree().current_scene.get_node("BGM").pause_mode = Node.PAUSE_MODE_INHERIT
	get_tree().current_scene.get_node("CanvasLayer/DialogHUD").pause_mode = Node.PAUSE_MODE_INHERIT
	paused_by_dialogs = false
	
func pause():
	if paused_by_dialogs:
		get_tree().paused = false
	get_tree().current_scene.get_node("BGM").pause_mode = Node.PAUSE_MODE_STOP
	get_tree().current_scene.get_node("CanvasLayer/DialogHUD").pause_mode = Node.PAUSE_MODE_STOP
	get_tree().paused = true
	
func resume():
	if paused_by_dialogs:
		get_tree().paused = false
		get_tree().current_scene.get_node("BGM").pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().current_scene.get_node("CanvasLayer/DialogHUD").pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
	else:
		get_tree().paused = false
		get_tree().current_scene.get_node("BGM").pause_mode = Node.PAUSE_MODE_INHERIT
	
