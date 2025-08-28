extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")


func set_score_display(score: int) -> void:
	$CanvasLayer/ScoreDisplay.text = "Score: " + str(score)
