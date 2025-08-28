extends Area2D

var velocity: Vector2 = Vector2.ZERO

var damage: int = 1

var pierce: int = 0
var pierce_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += velocity * delta


func set_sprite_rotation(angle: float) -> void:
	$Sprite2D.rotation = angle


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Delete the bullet when it leaves the screen
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	pierce_count += 1
	if pierce_count > pierce:
		queue_free()
