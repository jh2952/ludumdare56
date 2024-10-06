extends Node2D

const rotation_speed : float = 30.0

static var first_init = true

@onready var left: Sprite2D = $Sprite2D/Left
@onready var right: Sprite2D = $Sprite2D/Right
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.tongue_shoot_start.connect(_on_tongue_shoot_start)
	SignalManager.tongue_shoot_end.connect(_on_tongue_shoot_end)
	create_arrow_keys_UI()
	first_init = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_arrow_orientation(delta)

func handle_arrow_orientation(delta : float) -> void:
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		turn_off_tutorial_UI() 
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		turn_off_tutorial_UI()
	rotation_degrees = clamp(rotation_degrees, -50, 50)

func _on_tongue_shoot_start() -> void:
	set_process(false)
	visible = false

func _on_tongue_shoot_end() -> void:
	set_process(true)
	visible = true

func create_arrow_keys_UI() -> void:
	if not first_init:
		pass
	else:
		left.visible = true
		right.visible = true
		animation_player.play("flash_keys")

func turn_off_tutorial_UI() -> void:
	left.visible = false
	right.visible = false
	animation_player.stop()
