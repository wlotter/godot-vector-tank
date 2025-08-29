class_name PowerUpFactory
extends Object

enum POWER_UP_TYPE {PIERCE, DAMAGE, RATE_OF_FIRE}

static var type_texture_dict = {
	POWER_UP_TYPE.PIERCE: preload("res://assets/player/power-up/pierce-up.png"),
	POWER_UP_TYPE.DAMAGE: preload("res://assets/player/power-up/damage-up.png"),
	POWER_UP_TYPE.RATE_OF_FIRE: preload("res://assets/player/power-up/rate-of-fire-up.png"),
}

static var power_up_scene = preload("res://scenes/player/power_up.tscn")


static func make(type: POWER_UP_TYPE) -> Node2D:
	var node = power_up_scene.instantiate()
	
	node.power_up_type = type
	node.set_texture(type_texture_dict[type])
	
	return node


static func make_random() -> Node2D:
	return make(POWER_UP_TYPE.values().pick_random())
