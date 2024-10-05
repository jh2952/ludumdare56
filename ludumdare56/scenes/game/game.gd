extends Node2D

@onready var camera_2d: Camera2D = $Camera2D

var title_screen_scene : PackedScene = preload("res://scenes/title_screen/title_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.start_game.connect(_on_start_game)
	var title_screen_instance = title_screen_scene.instantiate()
	title_screen_instance.position = camera_2d.position + Vector2(500, 500)
	add_child(title_screen_instance)
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StateManager.current_state == StateManager.STATE_TRANSITIONING_INTO_GAME:
		transition_into_game(delta)
	if StateManager.current_state == StateManager.STATE_GAME:
		process_game(delta)

func _on_start_game() -> void:
	set_process(true)
	StateManager.current_state = StateManager.STATE_TRANSITIONING_INTO_GAME

func transition_into_game(delta : float) -> void:
	var target_y = 1000.0
	var camera_speed = 20.0
	
	camera_2d.position.y = lerp(camera_2d.position.y, target_y, 0.005)
	
	if abs(camera_2d.position.y - target_y) < 1:
		camera_2d.position.y = target_y
		StateManager.current_state = StateManager.STATE_GAME

func process_game(delta : float) -> void:
	pass
