extends PanelContainer

signal add_new_cat()

const BALL : PackedScene = preload("res://objects/ball.tscn")

@onready var mover : Movable = $Movable
@onready var ball_container : Node2D = $spawner
@onready var waga_number : Label = $buttonmargin/waga

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mover.object_to_move = self
	mover.showing_pos = Vector2(0, 946)
	mover.hiding_pos = Vector2(0, 3000)
	
	mover.set_displayed(true)

func _on_force_feed_pressed() -> void:
	ball_container.add_child(BALL.instantiate())


func _on_new_cat_pressed() -> void:
	emit_signal("add_new_cat")

func set_waga(to : String) -> void:
	waga_number.text = to
