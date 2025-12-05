extends CharacterBody3D
class_name Player

signal PointChanged(new_point:int)

var point :int = 0
func add_point() -> void:
	point += 1
	PointChanged.emit(point)
	
func hit_wall(body:Node3D) -> void:
	print("lost game")
	
@export var speed := 100
@export var gravity := 10
@export var lift_force := 10  # Control the plane's lift
@export var roll_sensitivity := 1.5  # How much the plane tilts during turns
@export var max_tilt := Vector3.ZERO  # Maximum tilt angle

var tilt_angle := Vector3.ZERO

func _physics_process(delta:float) -> void:
	var direction := Vector3.ZERO
	
	if Input.is_action_pressed("up"):
		direction.y += 1
	if Input.is_action_pressed("down"):
		direction.y -= 1
	if Input.is_action_pressed("right"):
		direction.x -= 1
	if Input.is_action_pressed("left"):
		direction.x += 1
	
	direction = direction.normalized()
	
	velocity.x = direction.x * speed * delta
	velocity.y = direction.y * lift_force * delta
	velocity.z = speed * delta
	
	velocity.y -= gravity * delta

	tilt_angle.z = clamp(tilt_angle.z - velocity.x * roll_sensitivity, -max_tilt.z, max_tilt.z)
	tilt_angle.y = clamp(tilt_angle.y + velocity.x * roll_sensitivity, -max_tilt.y, max_tilt.y)
	tilt_angle.x = clamp(tilt_angle.x - velocity.y * roll_sensitivity, -max_tilt.x, max_tilt.x)
	
	rotation_degrees = Vector3(tilt_angle.x, tilt_angle.y, tilt_angle.z)
	move_and_slide()
