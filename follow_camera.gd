extends Camera3D
class_name FollowCamera

@export var follow_target:Node3D
#@export var look_target:Node3D

func _process(delta: float) -> void:
	global_position = follow_target.global_position
	global_position.z -= 3
	global_position.y += 1
	look_at(follow_target.global_position)
