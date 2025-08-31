extends Enemy


@export var rocket_scene = preload("res://scenes/attacks/rocket.tscn")

var rotor_switch = 1

# Node to follow
var target_node: Node2D

var strafe_direction = 1

var linear_speed = 225
var strafe_speed = 150
var close_distance_threshold: int = 400
var far_distance_threshold: int = 600


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	health = 3
	enemy_class = Enemy.ENEMY_CLASS.ELITE
	kill_score = 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_rotor()
	
	if target_node == null:
		return
	
	var angle = position.angle_to_point(target_node.position)
	var distance = position.distance_to(target_node.position)
	
	var velocity = Vector2.from_angle(angle)
	if distance <= close_distance_threshold:
		# Player is too close, back off!
		$ShotTimer.paused = true
		velocity = -linear_speed * velocity
	elif distance <= far_distance_threshold:
		# Player at ideal distance, strafe them!
		$ShotTimer.paused = false
		velocity = strafe_speed * velocity.rotated(strafe_direction * PI / 2)
	else:
		# Player is too far, approach!
		#$ShotTimer.paused = true
		velocity = linear_speed * velocity
		
	rotation = angle
	position += velocity * delta
	
	
func update_rotor() -> void:
	if rotor_switch > 0:
		$ChopperRotor.rotate(PI / 8)
	rotor_switch *= -1


func _on_shot_timer_timeout() -> void:	
	var rockets = make_rocket_array()
	for rocket in rockets:
		get_parent().add_child(rocket)

func make_rocket_array():
	var off_set_angles = [
		-deg_to_rad(80),
		-deg_to_rad(50),
		deg_to_rad(50),
		deg_to_rad(80),
	]
	
	var rockets = []
	
	for angle in off_set_angles:
		var rocket = rocket_scene.instantiate()
		rocket.position = position
		rocket.target_position = target_node.position
		rocket.stop_one_position = position + \
				Vector2.from_angle(rotation + angle) * 70
		
		rockets.append(rocket)
		
	return rockets
