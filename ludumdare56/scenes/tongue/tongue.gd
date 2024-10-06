extends Node2D

const max_scale_y : float = 30.0
const scale_speed : float = 30.0
var is_shooting : bool = true
var current_creature : Node2D = null

@onready var tip_marker: Marker2D = $TongueTip/TipMarker

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_creature:
		move_creature()
	
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
			if current_creature:
				SignalManager.creature_eaten.emit()
				current_creature.queue_free()
			queue_free()

func _on_tongue_tip_body_entered(body: Node2D) -> void:
	is_shooting = false
	if body.is_in_group("creatures") and not current_creature:
		current_creature = body
		call_deferred("_disable_creature", current_creature)
		pass

func move_creature() -> void:
	current_creature.position = tip_marker.global_position
	print("Current Creature Position: ", current_creature.position)

func _disable_creature(body : Node2D) -> void:
	body.set_process(false)
	var creature_collision_shape = body.get_node("CollisionShape2D") as CollisionShape2D
	creature_collision_shape.disabled = true
