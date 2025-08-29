extends Area2D

var health = 3

var speed = 300
var angular_speed = PI
var viewport_size: Vector2
var turret_angle = PI

var invulnerable: bool = false
var hit_invulnerability_time: float = 2.0

signal health_update(health: int)
signal stat_update(stats: Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var rotation_speed = 0
	if Input.is_action_pressed("rotate clockwise"):
		rotation_speed += angular_speed
	if Input.is_action_pressed("rotate anticlockwise"):
		rotation_speed -= angular_speed
		
	rotation += rotation_speed * delta
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move forwards"):
		velocity += Vector2.from_angle(rotation)
	if Input.is_action_pressed("move backwards"):
		velocity -= Vector2.from_angle(rotation)
	
	position += speed * velocity * delta
	position = position.clamp(Vector2.ZERO, viewport_size)
	
	handle_turret()
	
	if Input.is_action_pressed("shoot"):
		shoot()


func handle_turret():
	var mp = get_viewport().get_mouse_position()
	var angle = position.angle_to_point(mp)
	
	turret_angle = angle
	$Turret.global_rotation = angle + PI / 2


func shoot():
	var angle = turret_angle	
	var shot_vector = Vector2.from_angle(angle)

	# Adjustment to put bullet at end of turret
	var shot_spawn_offset = (
			shot_vector * 
			$CollisionShape2D.shape.get_rect().size.x *
			scale.x
	)
	
	$WeaponGun.fire(get_parent(), position + shot_spawn_offset / 2, shot_vector)


func get_stats() -> Dictionary:
	return {
		"pierce": $WeaponGun.projectile_pierce,
		"rate_of_fire": snapped(1 / $WeaponGun.cooldown_time, 0.01),
		"damage": $WeaponGun.projectile_damage
	}


func upgrade_pierce() -> void:
	$WeaponGun.projectile_pierce += 1
	
	
func upgrade_rate_of_fire() -> void:
	$WeaponGun.cooldown_time = ($WeaponGun.cooldown_time) / (1 + $WeaponGun.cooldown_time)
	$WeaponGun.projectile_speed *= 1.05
	
	
func upgrade_damage() -> void:
	$WeaponGun.projectile_damage += 1


func _on_area_entered(area: Area2D) -> void:
	var power_up_type = area.get("power_up_type")
	if power_up_type != null:
		if power_up_type == PowerUpFactory.POWER_UP_TYPE.PIERCE:
			upgrade_pierce()
		elif power_up_type == PowerUpFactory.POWER_UP_TYPE.RATE_OF_FIRE:
			upgrade_rate_of_fire()
		elif power_up_type == PowerUpFactory.POWER_UP_TYPE.DAMAGE:
			upgrade_damage()
			
		stat_update.emit(get_stats())
		area.queue_free()
	
	elif not invulnerable:
		health -= 1
		if health <= 0:
			health = 0
		
		health_update.emit(health)
		
		invulnerable = true
		$Chassis.play("invulnerable")
		$Turret.play("invulnerable")
		
		var invuln_timer = get_tree().create_timer(hit_invulnerability_time)
		invuln_timer.timeout.connect(_on_invuln_timer_timeout)


func _on_invuln_timer_timeout() -> void:
	invulnerable = false
	$Chassis.stop()
	$Turret.stop()
	$Chassis.animation = "default"
	$Turret.animation = "default"
