extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var arrow_scene : PackedScene = preload("res://scenes/arrow/arrow.tscn")
@onready var tongue_scene : PackedScene = preload("res://scenes/tongue/tongue.tscn")
@onready var tongue_marker: Marker2D = $TongueRegionClip/TongueMarker
@onready var frog_open: AudioStreamPlayer2D = $FrogOpen


var tongue_node : Node2D
var arrow_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.tongue_shoot_end.connect(_on_tongue_shoot_end)
	animated_sprite_2d.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire_tongue") and not tongue_node:
		animated_sprite_2d.play("open")
		tongue_node = tongue_scene.instantiate()
		tongue_node.rotation = arrow_node.rotation
		tongue_marker.add_child(tongue_node)
		frog_open.play()
		SignalManager.tongue_shoot_start.emit()

# Create arrow node
func _on_start_game() -> void:
	set_process(true)
	arrow_node = arrow_scene.instantiate()
	add_child(arrow_node)

# Return the size of the frog sprite
func get_sprite_height() -> float:
	return animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation,animated_sprite_2d.frame).get_size().y

func _on_tongue_shoot_end() -> void:
	animated_sprite_2d.play("idle")
