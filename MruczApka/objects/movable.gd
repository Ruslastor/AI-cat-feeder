@icon("res://assets/moving-truck.png")
class_name Movable
extends Node

@export var object_to_move : PanelContainer
@export var showing_pos : Vector2
@export var hiding_pos : Vector2

var displaying : bool = false

func set_displayed(to : bool) -> void:
	if displaying and !to:
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(object_to_move, "position", hiding_pos, 1).set_trans(Tween.TRANS_EXPO)
	if !displaying and to:
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(object_to_move, "position", showing_pos, 1).set_trans(Tween.TRANS_EXPO)
	displaying = to
