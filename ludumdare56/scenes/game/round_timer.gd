extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.start_game.connect(_on_start_game)

func _process(delta: float) -> void:
	GameManager.time_remaining = int(time_left)

func _on_start_game() -> void:
	start()
	GameManager.time_remaining = int(time_left)

func _on_timeout() -> void:
	SignalManager.transition_out_game.emit()
