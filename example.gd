extends Node2D

@export var bullet_scene: PackedScene

var bullet_speed = 400 # should be elsewhere really

var score = 0

var player_health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().call_group("enemies", "set_target_position", $Tank.position)

	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		
		var angle = $Tank.turret_angle
		
		var shot_vector = Vector2.from_angle(angle)
		var shot_velocity = bullet_speed * shot_vector

		# Adjustment to put bullet at end of turret
		var shot_spawn_offset = (
				shot_vector * 
				$Tank.get_tank_rect().size.x *
				$Tank.scale.y
		)
		
		add_child(bullet)
		
		bullet.position = $Tank.position + shot_spawn_offset / 2
		bullet.linear_velocity = shot_velocity


func _on_enemy_spawner_spawned(enemy: Node2D) -> void:
	enemy.killed.connect(_on_enemy_killed) # Rep
	

func _on_enemy_killed(kill_score):
	score += kill_score
	$HUD.set_score(score)
	

func _on_tank_hit(damage: int) -> void:
	player_health -= damage
	player_health = 0 if player_health < 0 else player_health
	$HUD.set_health(player_health)
		
