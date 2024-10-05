extends Camera2D

const camera_velocity : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("camera_debug_up"):
		position.y -= camera_velocity
	if Input.is_action_pressed("camera_debug_down"):
		position.y += camera_velocity
