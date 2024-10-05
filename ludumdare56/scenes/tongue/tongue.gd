extends Node2D

const max_scale_y : float = 30.0
const scale_speed : float = 30.0
var is_shooting : bool = true

@onready var tongue_tip: Sprite2D = $TongueTip/TongueTip

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_shooting:
		if scale.y < max_scale_y:
			scale.y += scale_speed * delta
		else:
			is_shooting = false
	else:
		if scale.y > 0:
			scale.y -= scale_speed * delta
		else:
			SignalManager.tongue_shoot_end.emit()
			queue_free()


func _on_tongue_tip_body_entered(body: Node2D) -> void:
	is_shooting = false
