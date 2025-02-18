extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Robot failure variables
var direction_scaler = 1
var can_jump = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if can_jump:
			velocity.y = JUMP_VELOCITY
		else:
			print("cannot jump")
			# play fail sound

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction_scaler*direction.x * SPEED
		velocity.z = direction_scaler*direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	$Meshes.look_at(transform.origin + direction, Vector3.UP)

	move_and_slide()

func invert_direction():
	direction_scaler = -1
	
func jump_failure():
	can_jump = false

func apply_random_force():
	var force_magnitude = 10.
	var random_force = force_magnitude*Vector3(randf_range(-1.0, 1.0),randf_range(0., 1.0),randf_range(-1.0, 1.0))
	velocity += random_force

func repair():
	print("Repaired!")
	direction_scaler = 1
	can_jump = true
