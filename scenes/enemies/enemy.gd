class_name Enemy
extends Area2D


enum ENEMY_CLASS {MINION, ELITE}


signal killed(score)


var enemy_class: ENEMY_CLASS = ENEMY_CLASS.MINION
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
		
		if enemy_class == ENEMY_CLASS.ELITE:
			var drop_node = PowerUpFactory.make_random()
			drop_node.position = position
			get_parent().add_child(drop_node)
		
		queue_free()
