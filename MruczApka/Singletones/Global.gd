extends Node


var LOADED_CATS : Dictionary = {}
var FORCE_FEEDING_TIMES : PackedStringArray = []


var FOCUSED_CAT : CatData
var MAIN_SCENE : Control
var RASPBERRY : RaspberryTCP

func _ready() -> void:
	if !mrucz_exists():
		create_mrucz()
	load_cats()


func load_mrucz() -> Dictionary:
	var file : FileAccess = FileAccess.open('user://cat_resources.mrucz', FileAccess.READ)
	var data : Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	return data
	
func save_mrucz():
	var mrucz : Dictionary = {
		'cats': PackedStringArray(LOADED_CATS.keys()),
		'force_feeding_times':FORCE_FEEDING_TIMES
	}
	var file : FileAccess = FileAccess.open('user://cat_resources.mrucz', FileAccess.WRITE)
	file.store_string(JSON.stringify(mrucz))
	file.close()

func create_mrucz():
	var mrucz : Dictionary = {
		'cats': PackedStringArray([]),
		'force_feeding_times':PackedStringArray([])
	}
	var file : FileAccess = FileAccess.open('user://cat_resources.mrucz', FileAccess.WRITE)
	file.store_string(JSON.stringify(mrucz))
	file.close()


func mrucz_exists():
	return FileAccess.file_exists('user://cat_resources.mrucz')


func load_cats()->void:
	var data : Dictionary = load_mrucz()
	FORCE_FEEDING_TIMES = data['force_feeding_times']
	for i in data['cats']:
		var new_cat : CatData = ResourceLoader.load(i)
		var time_stamp : String = DateTime.get_current_datetime().datetime_to_string()
		
		if !(time_stamp in new_cat.cat_eaten_days) and len(new_cat.cat_eaten_days)>0:
			for k in DateTime.get_dates_from_to(new_cat.cat_eaten_days[-1], time_stamp):
				new_cat.cat_eaten_days.append(k)
				new_cat.cat_eaten_feed_statistics[k] = '0.0'
		LOADED_CATS[i] = new_cat

	

func save_cats()->void:
	save_mrucz()
	for i in LOADED_CATS:
		ResourceSaver.save(LOADED_CATS[i],i)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_cats()
		print('saved')



