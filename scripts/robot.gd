extends CharacterBody3D

# Constants
const SPEED = 5.0
const SPEED_RUN = 7.0
const JUMP_VELOCITY = 4.5
const FORCE_MAGNITUDE = 10.

# Robot failure variables
var jump_fail := false
var run_fail := false
var direction_fail := false
var random_bugs_fail := false
var direction_scaler := 1

var alive := true
var has_item := false
var points := 0
var speed = SPEED
var can_get_errors := false
var running := true

@onready var case_empty: Node3D = $Meshes/skip
@onready var case_full: Node3D = $"Meshes/skip-rocks"
@onready var jump_error_sound: AudioStreamPlayer = $JumpError
@onready var bug_timer: Timer = $BugTimer
@onready var error_timer: Timer = $ErrorTimer
@onready var gobot: Node3D = $"Meshes/3DGodotRobot"

const EXPLOSION = preload("res://scenes/Explosion.tscn")

func _physics_process(delta: float) -> void:
	
	# die if falling
	if position.y<-2:
		alive = false
	
	if Input.is_action_pressed("run") and not run_fail:
		running = true
		speed = SPEED_RUN
	else:
		running = false
		speed = SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if not jump_fail:
			velocity.y = JUMP_VELOCITY
		else:
			jump_error_sound.play()
			print("cannot jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction_scaler*direction.x * speed
		velocity.z = direction_scaler*direction.z * speed
		$Meshes.look_at(global_position - direction, Vector3.UP)
		if running:
			gobot.get_node("AnimationPlayer").play("Sprint")
		else:
			gobot.get_node("AnimationPlayer").play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
	if not velocity:
		gobot.get_node("AnimationPlayer").play("Idle")
		
	if not is_on_floor():
		gobot.get_node("AnimationPlayer").play("Jump")

func get_item():
	has_item = true
	case_empty.visible = false
	case_full.visible = true
	
func drop_item():
	has_item = false
	case_empty.visible = true
	case_full.visible = false

#---
# Robot errors methods
#---

func invert_direction():
	direction_scaler = -1
	direction_fail = true
	
func jump_failure():
	jump_fail = true

func run_failure():
	run_fail = true

func random_bugs():
	apply_random_force()
	set_bug_timer()
	random_bugs_fail = true

func apply_random_force(force_magnitude=FORCE_MAGNITUDE):
	
	var random_force = force_magnitude*Vector3(randf_range(-1.0, 1.0),randf_range(0., 1.0),randf_range(-1.0, 1.0))
	velocity += random_force
	var explosion = EXPLOSION.instantiate()
	add_child(explosion)

func repair():
	print("Repaired!")
	direction_scaler = 1
	jump_fail = false
	run_fail = false
	random_bugs_fail = false
	direction_fail = false
	if can_get_errors:
		error_timer.start()

func _on_bug_timer_timeout() -> void:
	if random_bugs_fail and alive:
		random_bugs()

func set_bug_timer(ti=2, tf=5):
	bug_timer.wait_time = randf_range(ti, tf)
	bug_timer.start()

func status():
	if not random_bugs_fail and not jump_fail and not run_fail and not direction_fail:
		if not can_get_errors:
			return "OK"
		else:
			return "Warning! System overheated - Expected to fail soon"
	var bugs = []
	if random_bugs_fail:
		bugs.append("random bugs")
	if jump_fail:
		bugs.append("jump disabled")
	if run_fail:
		bugs.append("run blocked")
	if direction_fail:
		bugs.append("direction failing")
	var status = ""
	for i in range(len(bugs)):
		status+=bugs[i]
		if i<len(bugs)-1:
			status+=", "
	return status


func _on_error_timer_timeout() -> void:
	
	var possible_bugs = []
	if not random_bugs_fail:
		possible_bugs.append("broken")
	if not jump_fail:
		possible_bugs.append("jump")
	if not run_fail:
		possible_bugs.append("run")
	if not direction_fail:
		possible_bugs.append("direction")
	
	if len(possible_bugs)>0:
		var bug = possible_bugs[randi() % possible_bugs.size()]
		
		if bug=="broken":
			random_bugs()
		elif bug=="jump":
			jump_failure()
		elif bug=="run":
			run_failure()
		elif bug=="direction":
			invert_direction()
	
	#else:
	#	alive=false

func start_failing():
	can_get_errors = true
	error_timer.start()
