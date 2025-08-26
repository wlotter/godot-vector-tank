extends Node2D

@export var projectile: PackedScene

var projectile_speed = 600 
var projectile_damage = 1
var projectile_pierce = 0

var cooldown_time: float = 0.2
var on_cooldown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func fire(parent: Object, origin: Vector2, direction: Vector2) -> void:
	if not on_cooldown:
		on_cooldown = true
		
		var bullet = projectile.instantiate()
		
		bullet.position = origin
		bullet.velocity = projectile_speed * direction.normalized()
		bullet.set_sprite_rotation(direction.angle() + PI/2)
		
		bullet.damage = projectile_damage
		bullet.pierce = projectile_pierce
		
		parent.add_child(bullet)
		
		get_tree().create_timer(cooldown_time).timeout.connect(_take_off_cooldown)


func _take_off_cooldown() -> void:
	on_cooldown = false
