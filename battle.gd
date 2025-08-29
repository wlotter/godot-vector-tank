extends Node2D

var enemy_truck = preload("res://scenes/enemies/enemy_truck.tscn")
var enemy_tank = preload("res://scenes/enemies/enemy_tank.tscn")

var score = 0

var spawn_count = 1 # how many enemies have spawned so far
var tank_spawn_divisor = 10 # how often tanks spawn (less is more common)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.set_stats($Tank.get_stats())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause game"):
		mount_pause_menu()
		get_tree().paused = true


func _on_enemy_killed(kill_score):
	score += kill_score
	$HUD.set_score(score)
	

func _on_enemy_spawn_timer_timeout() -> void:
	$EnemySpawnPath/EnemySpawnPathFollow.progress_ratio = randf()
	
	var enemy_type = enemy_tank if spawn_count % tank_spawn_divisor == 0 else enemy_truck
	var enemy = enemy_type.instantiate()
	
	enemy.position = $EnemySpawnPath/EnemySpawnPathFollow.position
	enemy.target_node = $Tank
	enemy.killed.connect(_on_enemy_killed)
	add_child(enemy)
	
	spawn_count += 1


func _on_enemy_spawn_rampup_timer_timeout() -> void:
	# Reduce time between enemy spawns
	$EnemySpawnPath/EnemySpawnTimer.wait_time *= 0.9
	if tank_spawn_divisor > 5:
		tank_spawn_divisor -= 1


func mount_pause_menu() -> void:
	var pause_menu = load("res://scenes/ui/pause_menu.tscn")
	add_child(pause_menu.instantiate())


func _on_tank_health_update(health: int) -> void:
	$HUD.set_health(health)
	if health <= 0:
		get_tree().paused = true
		var game_over_screen = load("res://scenes/ui/game_over.tscn").instantiate()
		game_over_screen.set_score_display(score)
		add_child(game_over_screen)


func _on_tank_stat_update(stats: Dictionary) -> void:
	$HUD.set_stats(stats)
