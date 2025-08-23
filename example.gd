extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Enemy.set_target_position($Tank.position)
	$Enemy2.set_target_position($Tank.position)

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass
