extends Enemy

# Node to follow
var target_node: Node2D

var linear_speed = 175
var strafe_speed = 100

var close_distance_threshold: int = 400
var far_distance_threshold: int = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	health = 5
	kill_score = 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target_node == null:
		return
	
	var angle = position.angle_to_point(target_node.position)
	var distance = position.distance_to(target_node.position)
	
	var velocity = Vector2.from_angle(angle)
	if distance <= close_distance_threshold:
		# Player is too close, back off!
		velocity = -linear_speed * velocity
	elif distance <= far_distance_threshold:
		# Player at ideal distance, strafe them!
		velocity = strafe_speed * velocity.rotated(PI / 2)
	else:
		# Player is too far, approach!
		velocity = linear_speed * velocity
		
	rotation = angle
	position += velocity * delta
