extends CharacterBody2D

signal request_target

const speed = 50.0
var target : Node2D = null
var dir = Vector2(-1, 0)

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

const pebble_scene = preload("res://scenes/pebble/pebble.tscn")
var pebble_dropped = false

func _ready() -> void:
	sprite_2d.play("default")
	connect("request_target", _on_request_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		position += dir * speed * delta
		
		if target_is_below():
			drop_pebble()

func _on_request_target(target_node : Node2D):
	target = target_node
	var direction = (target.position - position).normalized()
	var facing = direction.dot(Vector2(1, 0))
	if facing > 0:
		sprite_2d.flip_h = true
		dir *= -1

func target_is_below() -> bool:
	var x_diff = abs(target.global_position.x - position.x)
	return x_diff < 1.0

func drop_pebble() -> void:
	if not pebble_dropped:
		var pebble = pebble_scene.instantiate()
		pebble.global_position = global_position + Vector2(0, 20)
		get_parent().add_child(pebble)
		pebble_dropped = true
