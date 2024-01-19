extends PanelContainer

signal new_cat_added()

@onready var photo : TextureRect = $__/ctr/photo
@onready var captured_photo : TextureRect = $__/HBoxContainer/__2/preview


@onready var capture_button : Button = $__/HBoxContainer/capture
@onready var name_editor : LineEdit = $__/name
@onready var weight_editor : LineEdit = $__/weight
@onready var is_kitty : CheckBox = $__/is_kitty
@onready var submit_button : Button = $__/submit
@onready var mover : Movable = $Movable

var cat_data : CatData

func _ready() -> void:
	mover.object_to_move = self
	mover.showing_pos = Vector2(0, 0)
	mover.hiding_pos = Vector2(1500, 0)
	
	mover.set_displayed(false)

func set_picture(pic : Image) -> void:
	var text : ImageTexture = ImageTexture.create_from_image(pic)
	if capture_button.button_pressed:
		cat_data.cat_face = pic
		captured_photo.texture = text
	photo.texture = text

func intialize() -> void:
	cat_data = CatData.new()
#	cat_data.cat_face = Image.load_from_file("res://huh2.jpg")

func _on_name_text_changed(new_text: String) -> void:
	cat_data.cat_name = new_text
	
func _on_weight_text_changed(new_text: String) -> void:
	cat_data.cat_weight = float(new_text)
	
func _on_is_kitty_pressed() -> void:
	cat_data.cat_is_kitten = is_kitty.button_pressed
	_on_submit_pressed()

func _on_submit_pressed() -> void:
	cat_data.cat_eaten_feed_statistics = {
		"1;12;2023;5": 0.0,
		"28;11;2023;2": 0.6,
		"29;11;2023;3": 0.7,
		"2;12;2023;6": 0.0,
		"30;11;2023;4": 0.5,
		"3;12;2023;7": 0.0,
		"4;12;2023;1": 0.0,
		"5;12;2023;2": 0.9,
		"6;12;2023;3": 0.0,
		"7;12;2023;4": 0.0,
		"8;12;2023;5":0.0
	}
	cat_data.cat_eaten_days = ["28;11;2023;2", "29;11;2023;3", "30;11;2023;4", "1;12;2023;5", "2;12;2023;6", "3;12;2023;7", "4;12;2023;1", "5;12;2023;2", "6;12;2023;3", "7;12;2023;4"]

	Global.LOADED_CATS['user://'+cat_data.cat_name+'.tres'] = cat_data
	print(Global.LOADED_CATS)
	emit_signal("new_cat_added")


