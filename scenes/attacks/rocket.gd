extends Area2D


enum {INITIAL_LAUNCH, STOP_ONE, APPROACHING_TARGET}


var area_damage_scene: PackedScene = preload("res://scenes/attacks/rocket_area_damage.tscn")

var phase = INITIAL_LAUNCH

var stop_one_distance_tolerance: int = 10
var stop_one_position: Vector2
var stop_one_velocity: Vector2
var stop_one_speed = 150
var stop_one_wait: float = 0.8

var target_position: Vector2
var target_velocity: Vector2
var target_speed = 600

var last_distance_from_target = 1000000 # stupidly high to start with


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop_one_velocity = stop_one_speed * (stop_one_position - position).normalized()
	target_velocity = target_speed * (target_position - position).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if phase == INITIAL_LAUNCH:
		if (stop_one_position - position).length() < stop_one_distance_tolerance:
			phase == STOP_ONE
			get_tree().create_timer(stop_one_wait).timeout.connect(_after_stop_one_wait)
		else:
			position += stop_one_velocity * delta
	elif phase == APPROACHING_TARGET:
		var current_distance_from_target = (target_position - position).length()
		# if we've started getting further away from the target, then
		# we've gone past it, so detonate
		if current_distance_from_target > last_distance_from_target:
			var area_damage_node = area_damage_scene.instantiate()
			area_damage_node.position = position
			get_parent().add_child(area_damage_node)
			queue_free()
		else:
			last_distance_from_target = current_distance_from_target
			position += target_velocity * delta


func _after_stop_one_wait() -> void:
	phase = APPROACHING_TARGET
