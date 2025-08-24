extends Node2D

@export var bullet_scene: PackedScene

var basic_enemy_scene = preload("res://scenes/enemies/enemy.tscn")

var bullet_speed = 400 # should be elsewhere really

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$EnemySpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().call_group("enemies", "set_target_position", $Tank.position)

	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		
		var angle = $Tank.turret_angle
		
		var shot_vector = Vector2.from_angle(angle)
		var shot_velocity = bullet_speed * shot_vector

		# Adjustment to put bullet at end of turret
		var shot_spawn_offset = shot_vector * $Tank/Turret.texture.get_height() * $Tank.scale.y
		
		add_child(bullet)
		
		bullet.position = $Tank.position + shot_spawn_offset / 2
		bullet.linear_velocity = shot_velocity


func _on_enemy_spawner_spawned(enemy: Node2D) -> void:
	enemy.killed.connect(_on_enemy_killed) # Rep
	

func _on_enemy_killed(kill_score):
	score += kill_score
	$HUD.set_score(score)
	
