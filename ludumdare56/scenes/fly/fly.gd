extends Node2D

var target : Node2D = null
var speed : float = 200.01

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D

signal request_target

func _ready() -> void:
	connect("request_target", _on_request_target)
	if not StateManager.is_fly_audio_playing:
		StateManager.is_fly_audio_playing = true
		audio_stream_player_2d.play()

func _process(delta: float) -> void:
	if target:
		var direction = (target.position - position).normalized()
		position += direction * speed * delta
		var facing = direction.dot(Vector2(1, 0))
		if facing > 0:
			sprite_2d.flip_h = true
	if not StateManager.is_fly_audio_playing:
		StateManager.is_fly_audio_playing = true
		audio_stream_player_2d.play()

func _on_request_target(target_node : Node2D):
	target = target_node

func stop_fly_sound():
	StateManager.is_fly_audio_playing = false
	audio_stream_player_2d.stop()

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		stop_fly_sound()
