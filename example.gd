extends Node2D

var score = 0

var player_health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawner_spawned(enemy: Node2D) -> void:
	enemy.target_node = $Tank
	enemy.killed.connect(_on_enemy_killed) # Rep
	

func _on_enemy_killed(kill_score):
	score += kill_score
	$HUD.set_score(score)
	

func _on_tank_hit(damage: int) -> void:
	player_health -= damage
	player_health = 0 if player_health < 0 else player_health
	$HUD.set_health(player_health)
		
