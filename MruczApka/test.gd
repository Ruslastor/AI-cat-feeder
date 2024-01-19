extends Control


func _ready() -> void:
	Global.FOCUSED_CAT = Global.LOADED_CATS.values()[0]
	print(Global.FOCUSED_CAT.cat_name)
	$Statistics.initialize()
