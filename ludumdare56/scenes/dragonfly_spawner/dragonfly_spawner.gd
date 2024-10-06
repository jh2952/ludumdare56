extends Node2D

const dragonfly_scene = preload("res://scenes/dragonfly/dragonfly.tscn")

@onready var dragonfly_timer: Timer = $"../DragonflyTimer"
@onready var spawn_timer: Timer = $SpawnTimer

@onready var left: Node2D = $Left
@onready var right: Node2D = $Right
@onready var frog: Area2D = $"../frog"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)
	spawn_timer.stop()
	set_process(false)

func _on_start_game() -> void:
	set_process(true)

func _on_transition_out_game() -> void:
	set_process(false)
	spawn_timer.stop()
	for child in get_children():
		if child.is_in_group("creatures"):
			child.queue_free()

func _on_spawn_timer_timeout() -> void:
	var rand_dir = int(randf() < 0.5)
	var side_node
	if rand_dir:
		side_node = left
	else:
		side_node = right
	
	var top_marker = side_node.get_node("Top")
	var bot_marker = side_node.get_node("Bottom")
	
	var random_y = randf_range(
		bot_marker.global_position.y, 
		top_marker.global_position.y)
	
	var dragonfly_instance = dragonfly_scene.instantiate()
	dragonfly_instance.position = Vector2(side_node.global_position.x, random_y)
	add_child(dragonfly_instance)
	dragonfly_instance.emit_signal("request_target", frog)

func set_spawn_wait_time(time : float) -> void:
	spawn_timer.set_wait_time(time)

func _on_dragonfly_timer_timeout() -> void:
	spawn_timer.start()
