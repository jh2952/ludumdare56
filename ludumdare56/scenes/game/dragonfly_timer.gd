extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop()
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)

func _on_start_game() -> void:
	start()

func _on_transition_out_game() -> void:
	stop()
	set_wait_time(30.0)
