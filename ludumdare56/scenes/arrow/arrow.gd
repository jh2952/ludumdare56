extends Node2D

const rotation_speed : float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.tongue_shoot_start.connect(_on_tongue_shoot_start)
	SignalManager.tongue_shoot_end.connect(_on_tongue_shoot_end)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_arrow_orientation(delta)

func handle_arrow_orientation(delta : float) -> void:
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		
	rotation_degrees = clamp(rotation_degrees, -60, 60)

func _on_tongue_shoot_start() -> void:
	set_process(false)
	visible = false

func _on_tongue_shoot_end() -> void:
	set_process(true)
	visible = true
