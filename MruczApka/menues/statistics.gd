extends PanelContainer

@onready var mover : Movable = $Movable

@onready var next_week_button : Button = $_/buttons/forw
@onready var back_week_button : Button = $_/buttons/back

@onready var top_border : Line2D = $avg_p
@onready var avg_border : Line2D = $avg
@onready var bottom_border : Line2D = $avg_n
@onready var separator : Line2D = $underline

@onready var column_mon : VBoxContainer = $_/columns/Mon
@onready var column_tue : VBoxContainer = $_/columns/Tue
@onready var column_wed : VBoxContainer = $_/columns/Wed
@onready var column_thu : VBoxContainer = $_/columns/Thu
@onready var column_fri : VBoxContainer = $_/columns/Fri
@onready var column_sat : VBoxContainer = $_/columns/Sat
@onready var column_sun : VBoxContainer = $_/columns/Sun

@onready var cat_name_label : Label = $_/name

var columns : Array[VBoxContainer]

var deviation_parameters : Dictionary

var avg : float
var std : float

var base_timestamp_index : int = 0

var gradient : Gradient = Gradient.new()

func _ready() -> void:
	mover.object_to_move = self
	mover.showing_pos = Vector2(0, 1380)
	mover.hiding_pos = Vector2(0, 3000)
	
	mover.set_displayed(false)


func initialize() -> void:
	deviation_parameters = Global.FOCUSED_CAT.get_cat_deviation_parameters()
	cat_name_label.text = Global.FOCUSED_CAT.cat_name + ' cat statistics'
	columns = [column_mon, column_tue, column_wed, column_thu, column_fri, column_sat, column_sun]

	avg = deviation_parameters['avg']
	std = deviation_parameters['std']
	show_week_from_timestamp(DateTime.get_current_datetime().datetime_to_string())


	
func update_gradient() -> void:
	gradient.colors = []
	gradient.offsets = []
	gradient.add_point(0.1, Color.RED)
	gradient.add_point(avg, Color.LAWN_GREEN)
	gradient.add_point(avg - std, Color.YELLOW)
	gradient.add_point(avg + std, Color.YELLOW)
	gradient.add_point(0.9, Color.CYAN)


func show_week_from_timestamp(d_m_y_wd : StringName) -> void:
	base_timestamp_index = Global.FOCUSED_CAT.cat_eaten_days.find(d_m_y_wd) - (int(d_m_y_wd.split(';')[-1]) - 1)
	show_week_from_base_timestamp_index()

func show_week_from_base_timestamp_index() -> void:
	update_gradient()
	update_buttons()
	for i in 7:
		if base_timestamp_index + i < len(Global.FOCUSED_CAT.cat_eaten_days) and base_timestamp_index + i >= 0:
			var timestamp : StringName = Global.FOCUSED_CAT.cat_eaten_days[base_timestamp_index + i]
			var value : float = float(Global.FOCUSED_CAT.cat_eaten_feed_statistics[timestamp])
			var times : Array = timestamp.split(';')
			columns[i].grow_to(value, gradient.sample(value), times[0]+'/'+times[2])
		else:
			columns[i].grow_to(0, gradient.sample(0), '')
	allocate_border_lines()

func update_buttons()->void:
	back_week_button.visible = true
	next_week_button.visible = true
	if base_timestamp_index >= len(Global.FOCUSED_CAT.cat_eaten_days):
		next_week_button.visible = false
	if base_timestamp_index < 0:
		back_week_button.visible = false



func _on_back_pressed() -> void:
	base_timestamp_index -= 7
	show_week_from_base_timestamp_index()


func _on_forw_pressed() -> void:
	base_timestamp_index += 7
	show_week_from_base_timestamp_index()
	
func allocate_border_lines() -> void:
	var avg_lift : float = (1 - avg) * 400 + 100
	var top_lift : float = ( 1 - (avg + std) ) * 400 + 100
	var bot_lift : float =  ( 1 - (avg - std) ) * 400 + 100
	
	print(avg,' ', std,' ', self.position,' ', self.global_position)
	top_border.points = PackedVector2Array([
			Vector2(0,top_lift),
			Vector2(0 + self.size.x,top_lift),
		])
	bottom_border.points = PackedVector2Array([
			Vector2(0,bot_lift),
			Vector2(0 + self.size.x,bot_lift),
		])
	avg_border.points = PackedVector2Array([
			Vector2(0,avg_lift),
			Vector2(0 + self.size.x,avg_lift),
		])
	separator.points = PackedVector2Array([
			Vector2(-20,800),
			Vector2(self.size.x+20,800),
	])






