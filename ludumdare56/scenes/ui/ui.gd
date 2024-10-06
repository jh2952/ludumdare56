extends Control

@onready var score_label: Label = $MarginContainer/Score
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hearts_container: HBoxContainer = $MarginContainer/HeartsContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)
	SignalManager.take_damage.connect(_on_take_damage)
	visible = false
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_label.text = "score: " + str(GameManager.player_score)

func _on_start_game() -> void:
	visible = true
	set_process(true)
	animation_player.play("fade_in")

func _on_transition_out_game() -> void:
	animation_player.play("fade_out")
	set_process(false)
	var hearts = hearts_container.get_children()
	for i in range(GameManager.k_start_health):
		hearts[i].set_empty(false)
 
func _on_take_damage() -> void:
	var hearts = hearts_container.get_children()
	
	for i in range(GameManager.k_start_health):
		hearts[i].set_empty(true)
	
	for i in range(GameManager.player_health):
		hearts[i].set_empty(false)
