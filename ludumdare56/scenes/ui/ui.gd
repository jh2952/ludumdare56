extends Control

@onready var score_label: Label = $MarginContainer/Score
@onready var timer_label: Label = $MarginContainer/Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)
	visible = false
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "score: " + str(GameManager.player_score)
	timer_label.text = "time: " + str(GameManager.time_remaining)

func _on_start_game() -> void:
	visible = true
	set_process(true)
	animation_player.play("fade_in")

func _on_transition_out_game() -> void:
	animation_player.play("fade_out")
	set_process(false)
