extends Control

@onready var feed_camera : PanelContainer = $FeedCamera
@onready var cat_viewer : PanelContainer = $CatViewer
@onready var statistics : PanelContainer = $Statistics
@onready var cat_adder : PanelContainer = $CatAdder
@onready var time_manager : PanelContainer = $TimeManager
@onready var time_button : PanelContainer = $TimeButton
@onready var rpi : RaspberryTCP = $RaspberryTCP

func _ready() -> void:
	Global.MAIN_SCENE = self
	Global.RASPBERRY = rpi
	
	rpi.listen_to(12345)


const IMAGE_SIZE : int = 64
func _on_raspberry_tcp_got_data(command, data) -> void:
	match command:
		'p':
			var img : Image = Image.create(IMAGE_SIZE,IMAGE_SIZE,false,Image.FORMAT_RGB8)
			for y in IMAGE_SIZE:
				for x in IMAGE_SIZE:
					var st_point : int = (y * IMAGE_SIZE + x) * 6
					var b : float =  float((data[st_point] + data[st_point + 1]).hex_to_int()) / 255.0
					var g : float =  float((data[st_point + 2] + data[st_point + 3]).hex_to_int()) / 255.0
					var r : float =  float((data[st_point + 4] + data[st_point + 5]).hex_to_int()) / 255.0
					
					img.set_pixel(x,y,Color(r,g,b))
			img.flip_x()
			cat_adder.set_picture(img)
		'w':
			feed_camera.set_waga(data)



func _on_feed_camera_add_new_cat() -> void:
	time_button.mover.set_displayed(false)
	cat_viewer.mover.set_displayed(false)
	feed_camera.mover.set_displayed(false)
	cat_adder.intialize()
	cat_adder.mover.set_displayed(true)



func _on_cat_viewer_show_cat_statistics() -> void:
	time_button.mover.set_displayed(false)
	feed_camera.mover.set_displayed(false)
	statistics.mover.set_displayed(true)
	statistics.initialize()


func _on_cat_viewer_close_cat_statistics() -> void:
	statistics.mover.set_displayed(false)
	feed_camera.mover.set_displayed(true)
	time_button.mover.set_displayed(true)


func _on_cat_adder_new_cat_added() -> void:
	cat_adder.mover.set_displayed(false)
	feed_camera.mover.set_displayed(true)
	cat_viewer.list_all_cats_no_signal()
	cat_viewer.mover.set_displayed(true)
	time_button.mover.set_displayed(true)
	Global.save_cats()



func _on_time_button_show_time_editor() -> void:
	time_manager.open_with_times(Global.FORCE_FEEDING_TIMES)
	time_button.mover.set_displayed(false)
	cat_viewer.mover.set_displayed(false)
	time_button.mover.set_displayed(false)
	feed_camera.mover.set_displayed(false)
	time_manager.mover.set_displayed(true)
	

func _on_time_manager_close_time_manager() -> void:
	time_manager.mover.set_displayed(false)
	cat_viewer.mover.set_displayed(true)
	time_button.mover.set_displayed(true)
	feed_camera.mover.set_displayed(true)
	time_button.mover.set_displayed(true)
	






