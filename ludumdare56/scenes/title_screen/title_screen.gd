extends Control

@onready var high_score: Label = $MarginContainer2/HighScore

func _ready() -> void:
	SignalManager.transition_out_game.connect(_on_transition_out_game)
	high_score.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GameManager.high_score > 0: 
		high_score.visible = true
		high_score.text = "High Score: " + str(int(GameManager.high_score))
	
	if Input.is_action_just_pressed("start_game"):
		SignalManager.transition_into_game.emit()
		set_process(false)

func _on_transition_out_game() -> void:
	set_process(true)
