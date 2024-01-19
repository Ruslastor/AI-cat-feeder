extends VBoxContainer
@onready var date : Label = $date
@onready var weekday : Label = $weekday
@onready var column : ColorRect = $column

@export var wd : String

func _ready() -> void:
	weekday.text = wd

func grow_to(percent : float, color : Color, dt : String) -> void:
	column.color = color
	date.text = dt
	get_tree().create_tween().tween_property(
		column, "custom_minimum_size", Vector2(100, percent * 600.0), 1
		).set_trans(Tween.TRANS_EXPO)
	
	
