extends Node2D

@onready var camera_2d: Camera2D = $Camera2D

var title_screen_scene : PackedScene = preload("res://scenes/title_screen/title_screen.tscn")
@onready var music: AudioStreamPlayer = $Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.transition_into_game.connect(_on_transition_into_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)
	SignalManager.creature_eaten.connect(_on_creature_eaten)
	var title_screen_instance = title_screen_scene.instantiate()
	title_screen_instance.position = camera_2d.position + Vector2(500, 500)
	add_child(title_screen_instance)
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StateManager.current_state == StateManager.STATE_TRANSITIONING_INTO_GAME:
		transition_into_game(delta)
	if StateManager.current_state == StateManager.STATE_TRANSITIONING_OUT_GAME:
		transition_out_game(delta)
	if StateManager.current_state == StateManager.STATE_GAME:
		process_game(delta)

func _on_transition_into_game() -> void:
	set_process(true)
	StateManager.current_state = StateManager.STATE_TRANSITIONING_INTO_GAME

func _on_transition_out_game() -> void:
	StateManager.current_state = StateManager.STATE_TRANSITIONING_OUT_GAME

func _on_creature_eaten() -> void:
	GameManager.player_score += 1

func transition_into_game(_delta : float) -> void:
	var target_y = 0000.0
	
	camera_2d.position.y = lerp(camera_2d.position.y, target_y, 0.01)
	
	if abs(camera_2d.position.y - target_y) < 1:
		camera_2d.position.y = target_y
		StateManager.current_state = StateManager.STATE_GAME
		SignalManager.start_game.emit()

func transition_out_game(_delta : float) -> void:
	var target_y = -5000.0
	
	camera_2d.position.y = lerp(camera_2d.position.y, target_y, 0.01)
	
	if abs(camera_2d.position.y - target_y) < 1:
		camera_2d.position.y = target_y
		StateManager.current_state = StateManager.STATE_START
		SignalManager.start_shop.emit()
		set_process(false)

func process_game(_delta : float) -> void:
	pass

func process_shop(_delta : float) -> void:
	pass
