extends Control

@onready var despawn_timer: Timer = $DespawnTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start_game"):
		SignalManager.transition_into_game.emit()
		despawn_timer.start()


func _on_despawn_timer_timeout() -> void:
	queue_free()
