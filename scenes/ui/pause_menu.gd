extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause game"):
		unpause()


func _on_button_button_up() -> void:
	unpause()


func unpause() -> void:
	get_tree().paused = false
	queue_free()
