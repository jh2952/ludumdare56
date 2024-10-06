extends Panel

@onready var sprite_2d: Sprite2D = $Sprite2D

func set_empty(value : bool) -> void:
	if value:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
