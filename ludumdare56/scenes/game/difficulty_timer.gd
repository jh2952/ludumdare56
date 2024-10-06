extends Timer

@onready var fly_spawner: Node2D = $"../FlySpawner"
@onready var dragonfly_spawner: Node2D = $"../DragonflySpawner"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop()
	SignalManager.start_game.connect(_on_start_game)
	SignalManager.transition_out_game.connect(_on_transition_out_game)

func _on_start_game() -> void:
	set_process(true)
	start()

func _on_transition_out_game() -> void:
	set_process(false)
	stop()
	set_wait_time(20.0)
	reset_spawn_period()


func _on_timeout() -> void:
	GameManager.fly_spawn_timer = max(1, GameManager.fly_spawn_timer - 1)
	GameManager.dragonfly_spawn_timer = max(2, GameManager.dragonfly_spawn_timer - 1)
	fly_spawner.set_spawn_wait_time(GameManager.fly_spawn_timer)
	dragonfly_spawner.set_spawn_wait_time(GameManager.dragonfly_spawn_timer)

func reset_spawn_period() -> void:
	GameManager.fly_spawn_timer = GameManager.k_start_fly_spawn_time
	GameManager.dragonfly_spawn_timer = GameManager.k_start_dragonfly_spawn_time
	fly_spawner.set_spawn_wait_time(GameManager.k_start_fly_spawn_time)
	dragonfly_spawner.set_spawn_wait_time(GameManager.k_start_dragonfly_spawn_time)
