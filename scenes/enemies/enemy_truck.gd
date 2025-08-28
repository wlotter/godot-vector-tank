extends Enemy

var speed = 200

# Node to follow
var target_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target_node == null:
		return
	
	var angle = position.angle_to_point(target_node.position)
	var velocity = Vector2.from_angle(angle)
	
	rotation = angle
	position += speed * velocity * delta
