extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if $TowerRange.has_overlapping_areas():
		var target = $TowerRange.get_overlapping_areas()[0]

		var shot_vector = (target.position - position).normalized()

		$WeaponGun.fire(get_parent(), position, shot_vector)
