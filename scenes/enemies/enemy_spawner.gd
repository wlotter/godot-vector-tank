extends Node2D

@export var enemy_scene: PackedScene

signal spawned(enemy: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	
	get_tree().root.add_child(enemy)
	
	spawned.emit(enemy)
	
