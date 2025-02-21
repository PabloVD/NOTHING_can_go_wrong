extends Node3D

const POINTS_TO_WIN := 20

@onready var game_ui: Control = $GameUI
@onready var robot: CharacterBody3D = $Robot
@onready var game_over: Control = $GameOver

@onready var comp_spawn = $computers_spawn
@onready var mine_spawn = $mine_spawn
@onready var barrel_spawn = $barrels_spawn
@onready var production_spawn = $production_line_spawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set the names of each spawner
	comp_spawn.Name = 'computer'
	mine_spawn.Name = 'mine'
	barrel_spawn.Name = 'barrel'
	production_spawn.Name = 'production'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_ui.get_node("Points").text = "Points: "+str(robot.points)
	game_ui.get_node("Status").text = "Status: "+str(robot.status())
	game_ui.get_node("ErrorBar").size = Vector2(robot.error_timer.time_left/20.*1100,25)  # terribly hardcoded esto eh

	var led_status = [
		Globals.led_status['computer'],
		Globals.led_status['mine'], 
		Globals.led_status['barrel'],
		Globals.led_status['production']
		]
	
	if not robot.alive or led_status.any(func(item): item>3):
		lose()
		
	if robot.points>=POINTS_TO_WIN:
		win()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$PauseMenu.visible = true
		get_tree().paused = true

func check_if_item_not_spawned(id, spawn_list):
	return not spawn_list[id].ItemSpawned


func _on_item_gen_timer_timeout() -> void:
	const ID_LIST = [0,1,2,3]
	var spawns = [comp_spawn, mine_spawn, barrel_spawn, production_spawn]
	
	var available_spawns = ID_LIST.filter(func(id): return check_if_item_not_spawned(id, spawns))
	if not available_spawns.is_empty():
		var id_spawn = available_spawns.pick_random()
		var spawner = spawns[id_spawn]
		spawner.spawn_item()

func lose():
	game_over.visible = true
	Globals.game_over()

func win():
	$Success.visible = true
