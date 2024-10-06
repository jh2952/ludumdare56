extends Control

func _ready() -> void:
	SignalManager.transition_out_game.connect(_on_transition_out_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start_game"):
		SignalManager.transition_into_game.emit()
		set_process(false)

func _on_transition_out_game() -> void:
	set_process(true)
