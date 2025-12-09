extends CharacterBody3D
class_name Player

signal PointChanged(new_point:int)

var point :int = 0
func add_point() -> void:
	point += 1
	PointChanged.emit(point)
	
func hit_wall(body:Node3D) -> void:
	print("lost game")
	
@export var speed :float= 2
@export var gravity :float= 0.5
@export var lift_force :float= 2  # Control the plane's lift
@export var roll_sensitivity :float= 1.5  # How much the plane tilts during turns
@export var up_down_sensitivity :float= 2  # How much the plane tilts during turns
@export var max_tilt := Vector3(10,2,10)  # Maximum tilt angle

var tilt_angle := Vector3.ZERO
var direction := Vector3.ZERO
var accel := Vector3.ZERO

@export var accel_label:Label
func _process(delta: float) -> void:
	accel = Input.get_accelerometer()

	# approximate gravity magnitude
	var g := 9.8

	# normalized tilt (-1 to 1)
	direction.x = clamp(-accel.x  / g, -1.0, 1.0)
	direction.y = clamp(accel.z / g, -1.0, 1.0)
	
	if Input.is_action_pressed("up"):
		direction.y += 1
	if Input.is_action_pressed("down"):
		direction.y -= 1
	if Input.is_action_pressed("right"):
		direction.x -= 1
	if Input.is_action_pressed("left"):
		direction.x += 1
	
	direction = direction.normalized()

func _physics_process(delta:float) -> void:	
	velocity.x = direction.x * speed
	#velocity.z = speed
	
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#velocity.y += direction.y * lift_force * delta * up_down_sensitivity


	#tilt_angle.z = clamp(tilt_angle.z - velocity.x * roll_sensitivity, -max_tilt.z, max_tilt.z)
	tilt_angle.y = clamp(tilt_angle.y + velocity.x * roll_sensitivity, -max_tilt.y, max_tilt.y)
	print(tilt_angle.y)
	#tilt_angle.x = clamp(tilt_angle.x - velocity.y * roll_sensitivity, -max_tilt.x, max_tilt.x)

	rotation_degrees = Vector3(tilt_angle.x, tilt_angle.y, tilt_angle.z)
	
	accel_label.text = str(accel) + "\n" + str(direction) + "\n" + str(velocity)
	move_and_slide()
