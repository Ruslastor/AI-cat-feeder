extends Button




func _on_toggled(button_pressed: bool) -> void:
	if button_pressed:
		self.text = IP.get_local_addresses()[1]
	else:
		self.text = ''
