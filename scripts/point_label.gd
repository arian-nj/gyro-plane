extends Label



func _on_player_point_changed(new_point: int) -> void:
	self.text = str(new_point)
