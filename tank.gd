extends Area2D

var speed = 400
var angular_speed = PI
var viewport_size: Vector2
var turret_angle = PI

var invulnerable: bool = false
var hit_invulnerability_time: float = 2.0

signal hit(damage: int)

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

func handle_turret():
	var mp = get_viewport().get_mouse_position()
	var angle = position.angle_to_point(mp)
	
	turret_angle = angle
	$Turret.global_rotation = angle + PI / 2


func get_tank_rect() -> Rect2:
	return $CollisionShape2D.shape.get_rect()


func _on_area_entered(area: Area2D) -> void:
	if not invulnerable:
		print("hi")
		hit.emit(1)
		invulnerable = true
		var invuln_timer = get_tree().create_timer(hit_invulnerability_time)
		invuln_timer.timeout.connect(_on_invuln_timer_timeout)
		$Chassis.play("invulnerable")
		$Turret.play("invulnerable")


func _on_invuln_timer_timeout() -> void:
	invulnerable = false
	$Chassis.stop()
	$Turret.stop()
	$Chassis.animation = "default"
	$Turret.animation = "default"
