extends PanelContainer

signal show_time_editor()

@onready var mover : Movable = $Movable

func _ready() -> void:
	mover.object_to_move = self
	mover.showing_pos = Vector2(880, 1175)#1175
	mover.hiding_pos = Vector2(1500, 1175)
	mover.set_displayed(true)

func _on_show_pressed() -> void:
	emit_signal("show_time_editor")
	
