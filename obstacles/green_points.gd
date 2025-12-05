extends Area3D


var tween:Tween
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player:Player = body
		player.add_point()
		print("I am being Touched " + str(player.point))
		
		tween = create_tween()
		tween.tween_property(self,"scale",Vector3(.1,.1,.1),.5)
		tween.tween_callback(self.queue_free)
	#
