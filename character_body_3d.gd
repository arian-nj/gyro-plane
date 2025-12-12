extends CharacterBody3D
class_name Player

signal PointChanged(new_point:int)

var point :int = 0
func add_point() -> void:
	point += 1
	PointChanged.emit(point)
	
func hit_wall(_body:Node3D) -> void:
	print("lost game")
	
@export var max_lr_speed :float= 2
@export var max_td_speed :float= 2
@export var push_velocity :float = 2
@export var gravity :float= 0.5
@export var roll_sensitivity :float= 1.5
@export var up_down_sensitivity :float= 2
@export var left_right_sensitivity :float= 2 
@export var max_tilt := Vector3(10,2,10)

var tilt_angle := Vector3.ZERO
var direction := Vector3.ZERO
var accel := Vector3.ZERO

@export var accel_label:Label

func _process(_delta: float) -> void:
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
	velocity.x += direction.x * delta * left_right_sensitivity
	velocity.x = clamp(velocity.x,-max_lr_speed,max_lr_speed)
	
	velocity.z = push_velocity
		
	if direction.y == 0:
		velocity.y -= gravity * delta
	else:
		velocity.y += direction.y * delta * up_down_sensitivity
	
	velocity.y = clamp(velocity.y,-max_td_speed,max_td_speed)
	
	var rotation_impactor := direction
	
	if direction.x == 0:
		rotation_impactor.x = velocity.x
	if direction.z == 0:
		rotation_impactor.z = velocity.z
	if direction.y == 0:
		rotation_impactor.y = velocity.y
		
	tilt_angle.z = clamp(tilt_angle.z - rotation_impactor.x * roll_sensitivity, -max_tilt.z, max_tilt.z)
	tilt_angle.y = clamp(tilt_angle.y + rotation_impactor.x * roll_sensitivity, -max_tilt.y, max_tilt.y)
	tilt_angle.x = clamp(tilt_angle.x - rotation_impactor.y * roll_sensitivity, -max_tilt.x, max_tilt.x)

	#rotation_degrees = Vector3(tilt_angle.x, tilt_angle.y, tilt_angle.z)
	#rotate_x()
	if accel_label:
		accel_label.text = str(accel) + "\n" + str(direction) + "\n" + str(velocity)
	move_and_slide()
