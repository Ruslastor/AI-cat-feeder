extends PanelContainer

@onready var hours_label : Label = $_/Hours/hours
@onready var minutes_label : Label = $_/minutes/minutes

@onready var h_plus : Button = $_/Hours/hours_plus
@onready var h_minu : Button = $_/Hours/hours_min

@onready var m_plus : Button = $_/minutes/minutes_plus
@onready var m_minu : Button = $_/minutes/minutes_min


func load_from_string(string : String) -> void:
	var data : PackedStringArray = string.split(':')
	hours_label.text = data[0]
	minutes_label.text = data[1]

func get_string() -> String:
	return hours_label.text + ":" + minutes_label.text

var accumulator : float = 0
func _process(delta: float) -> void:
	if h_plus.button_pressed:
		accumulator += delta
		if accumulator > 0.5:
			_on_hours_plus_pressed()
	elif h_minu.button_pressed:
		accumulator += delta
		if accumulator > 0.5:
			_on_hours_min_pressed()
	elif m_plus.button_pressed:
		accumulator += delta
		if accumulator > 0.5:
			_on_minutes_plus_pressed()
	elif m_minu.button_pressed:
		accumulator += delta
		if accumulator > 0.5:
			_on_minutes_min_pressed()
	else:
		accumulator = 0

func _on_hours_plus_pressed() -> void:
	var cur_hour : int = int(hours_label.text)
	cur_hour += 1
	if cur_hour > 23:
		cur_hour = 0
	hours_label.text = str(cur_hour)
	
func _on_minutes_plus_pressed() -> void:
	var cur_minu : int = int(minutes_label.text)
	cur_minu += 1
	if cur_minu > 59:
		cur_minu = 0
	minutes_label.text = str(cur_minu)


func _on_hours_min_pressed() -> void:
	var cur_hour : int = int(hours_label.text)
	cur_hour -= 1
	if cur_hour < 0:
		cur_hour = 23
	hours_label.text = str(cur_hour)
	
func _on_minutes_min_pressed() -> void:
	var cur_minu : int = int(minutes_label.text)
	cur_minu -= 1
	if cur_minu < 0:
		cur_minu = 59
	minutes_label.text = str(cur_minu)


func _on_delete_pressed() -> void:
	self.queue_free()
