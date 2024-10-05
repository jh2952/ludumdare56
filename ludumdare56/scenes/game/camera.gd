extends Camera2D

const camera_velocity : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.transition_into_game.connect(_on_transition_into_game)
	set_process(false)

func _on_transition_into_game() -> void:
	set_process(true)
