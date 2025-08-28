class_name Enemy
extends Area2D

signal killed(score)

var kill_score: int = 100
var health: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	health -= area.damage
	if health < 1:
		killed.emit(kill_score)
		queue_free()
