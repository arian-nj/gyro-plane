extends Camera3D
class_name FollowCamera

@export var follow_target:Node3D
#@export var look_target:Node3D

func _process(_delta: float) -> void:
	global_position = follow_target.global_position
	global_position.z -= 2
	global_position.y += .4
	look_at(follow_target.global_position)
