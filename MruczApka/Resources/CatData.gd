class_name CatData
extends Resource



@export var cat_name : StringName = ''
@export var cat_face : Image
@export var cat_interface_color : Color

@export var cat_is_kitten : bool = false
@export var cat_weight : float = 0

@export var cat_eaten_feed_statistics : Dictionary = {}
@export var cat_eaten_days : PackedStringArray = []
#{'mounth|day|weekday':12.90}

func get_cat_deviation_parameters() -> Dictionary:
	var data : PackedFloat64Array = cat_eaten_feed_statistics.values()
	var avg : float = 0.0
	var n : int = 0
	for i in data:
		if i > 0:
			avg += i
			n += 1
	avg /= n
	
	var std : float = 0.0
	for i in data:
		if i > 0:
			std += pow(i - avg,2)
	std = pow(std/n, 0.5)
	return {'avg':avg, 'std':std}
