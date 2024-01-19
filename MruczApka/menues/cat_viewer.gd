extends PanelContainer

signal show_cat_statistics()
signal close_cat_statistics()

const CAT_ICON : PackedScene = preload("res://menues/cat_icon.tscn")

@onready var cat_container : HBoxContainer = $ref_point/_/cat_container
@onready var mover : Movable = $Movable


func _ready() -> void:
	mover.object_to_move = self
	mover.showing_pos = Vector2(0, 0)
	mover.hiding_pos = Vector2(0, -1000)
	
	mover.set_displayed(true)
	list_all_cats_no_signal()

func list_all_cats_no_signal() -> void:
	clear_all_cats()
	for i in Global.LOADED_CATS.values():
		var new_cat : PanelContainer = CAT_ICON.instantiate()
		cat_container.add_child(new_cat)
		new_cat.connect("icon_pressed", Callable(show_one_cat))
		new_cat.show_cat(i)

func list_all_cats(cat : CatData) -> void:
	clear_all_cats()
	for i in Global.LOADED_CATS.values():
		var new_cat : PanelContainer = CAT_ICON.instantiate()
		cat_container.add_child(new_cat)
		new_cat.connect("icon_pressed", Callable(show_one_cat))
		new_cat.show_cat(i)
	emit_signal("close_cat_statistics")

func show_one_cat(cat : CatData) -> void:
	clear_all_cats()
	var new_cat : PanelContainer = CAT_ICON.instantiate()
	cat_container.add_child(new_cat)
	new_cat.connect("icon_pressed", Callable(list_all_cats))
	new_cat.show_cat(cat)
	Global.FOCUSED_CAT = cat
	emit_signal("show_cat_statistics")


func clear_all_cats() -> void:
	for i in cat_container.get_children():
		i.queue_free()
