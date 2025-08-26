extends Area2D

var kill_score = 100
var speed = 200

var health = 1

# Node to follow
var target_node: Node2D

signal killed(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target_node == null:
		return
	
	var angle = position.angle_to_point(target_node.position)
	var velocity = Vector2.from_angle(angle)
	
	rotation = angle
	position += speed * velocity * delta


func _on_area_entered(area: Area2D) -> void:
	health -= area.damage
	if health < 1:
		killed.emit(kill_score)
		queue_free()
