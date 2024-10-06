extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_location: PathFollow2D = $SpawnerPath/SpawnLocation
@onready var frog: Node2D = $"../frog"

var fly_scene : PackedScene = preload("res://scenes/fly/fly.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.stop()
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out)
	set_process(false)

func _on_spawn_timer_timeout() -> void:
	var fly_node = fly_scene.instantiate()
	spawn_location.progress_ratio = randf()
	fly_node.position = spawn_location.position
	add_child(fly_node)
	fly_node.emit_signal("request_target", frog)

func _on_start_game() -> void:
	set_process(true)
	spawn_timer.start()

func _on_transition_out() -> void:
	set_process(false)
	spawn_timer.stop()
	for child in get_children():
		if child.is_in_group("creatures"):
			child.queue_free()

func set_spawn_wait_time(time : float) -> void:
	spawn_timer.set_wait_time(time)
