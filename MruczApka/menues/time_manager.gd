extends PanelContainer

const TIME_NODE : PackedScene = preload("res://objects/time_node.tscn")

@onready var container : VBoxContainer = $_/_/_/container
@onready var mover : Movable = $Movable

signal close_time_manager()

func _ready() -> void:
	
	mover.object_to_move = self
	mover.showing_pos = Vector2(0, 0)
	mover.hiding_pos = Vector2(1500, 0)
	mover.set_displayed(false)
	


func open_with_times(times : PackedStringArray) -> void:
	for i in container.get_children():
		i.queue_free()
	for i in times:
		var time_node : PanelContainer = TIME_NODE.instantiate()
		container.add_child(time_node)
		time_node.load_from_string(i)


func _on_add_new_pressed() -> void:
	var time_node : PanelContainer = TIME_NODE.instantiate()
	var data : Dictionary = Time.get_time_dict_from_system()
	container.add_child(time_node)
	time_node.load_from_string(str(data['hour']) + ':' + str(data['minute']))
	
func _on_go_back_pressed() -> void:
	for i in get_time_list():
		if !(i in Global.FORCE_FEEDING_TIMES):
			Global.FORCE_FEEDING_TIMES.push_back(i)
	Global.save_cats()
	Global.RASPBERRY.send('t',';'.join(Global.FORCE_FEEDING_TIMES))
	emit_signal("close_time_manager")

func get_time_list() -> PackedStringArray:
	var a : PackedStringArray = []
	for i in container.get_children():
		a.push_back(i.get_string())
	return a
