extends Label



func _on_player_point_changed(new_point: int) -> void:
	self.text = str(new_point)


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
