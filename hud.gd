extends Control

var full_health_color = Color.from_rgba8(57, 166, 0) # green
var empty_health_color = Color.BLACK

var health_pips: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_pips.append($CanvasLayer/PanelContainer/HealthBar/HealthPip1)
	health_pips.append($CanvasLayer/PanelContainer/HealthBar/HealthPip2)
	health_pips.append($CanvasLayer/PanelContainer/HealthBar/HealthPip3)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_score(score):
	$CanvasLayer/Label.text = str(score)


func set_health(value: int):
	for i in range(value):
		health_pips[i].color = full_health_color
		
	for i in range(len(health_pips) - value): 
		health_pips[-(i + 1)].color = empty_health_color
