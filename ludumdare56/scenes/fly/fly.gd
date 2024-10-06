extends Node2D

var target : Node2D = null
var speed : float = 200.0

signal request_target

func _ready() -> void:
	connect("request_target", _on_request_target)

func _process(delta: float) -> void:
	if target:
		var direction = (target.position - position).normalized()
		position += direction * speed * delta

func _on_request_target(target_node : Node2D):
	target = target_node
