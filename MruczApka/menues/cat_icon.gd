extends PanelContainer

signal icon_pressed(cat : CatData)

@onready var image : TextureButton = $ref_point/icon
@onready var text : Label = $ref_point/name

var cat_instance : CatData

func show_cat(cat_data : CatData) -> void:
	
	cat_instance = cat_data
	
	var texture : ImageTexture = ImageTexture.create_from_image(cat_data.cat_face)
	text.text = cat_data.cat_name

	image.texture_pressed = texture
	image.texture_disabled = texture
	image.texture_focused = texture
	image.texture_hover = texture
	image.texture_normal = texture
	image.texture_pressed = texture
	
	


func _on_icon_pressed() -> void:
	emit_signal("icon_pressed", cat_instance)
