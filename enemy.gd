extends StaticBody2D

var speed = 200
var target_position = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target_position == null:
		return
	
	var angle = position.angle_to_point(target_position)
	var velocity = Vector2.from_angle(angle)
	
	rotation = angle
	position += speed * velocity * delta

func set_target_position(pos: Vector2):
	target_position = pos
