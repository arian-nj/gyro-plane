extends Node3D
class_name WorldSpawner

@export var SpawnList:Array[PackedScene]
@export var spawn_quantity : int = 10
@export var spawn_offset: Vector3 = Vector3(0, 0, 3)

var last_obstacle_pos := Vector3(0,0,0)

func _ready() -> void:
	for n in range(spawn_quantity):
		last_obstacle_pos += spawn_offset
		print(spawn_offset.x," ",spawn_offset.y," ",spawn_offset.z)
		var obstacleScene:PackedScene = SpawnList.pick_random()
		var instance:Node3D = obstacleScene.instantiate()
		
		instance.position = last_obstacle_pos
		instance.position.y += randf_range(0, 3)
		instance.position.x += randf_range(-3, 3)
		
		add_child(instance)
