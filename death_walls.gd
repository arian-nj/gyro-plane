extends Area3D
class_name DeathWall

var tween:Tween
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player:Player = body
		player.hit_wall(self)
		
		tween = create_tween()
		tween.tween_property(self,"scale",Vector3(2,2,2),.5)
		tween.tween_callback(get_tree().reload_current_scene)
	
