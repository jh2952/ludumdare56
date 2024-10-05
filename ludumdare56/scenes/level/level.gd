extends Node2D

@onready var clouds: Parallax2D = $Clouds

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clouds.scroll_offset.x -= 10 * delta
