extends Area2D

var power_up_type = PowerUpFactory.POWER_UP_TYPE.PIERCE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Sprite2D.texture)
	print($Sprite2D.visible)
	print(visible)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_texture(texture: CompressedTexture2D) -> void:
	$Sprite2D.texture = texture
	
