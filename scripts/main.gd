extends Node3D

var points := 0
@onready var game_ui: Control = $GameUI
@onready var robot: CharacterBody3D = $Robot
@onready var game_over: Control = $GameOver

@onready var comp_spawn = $computers_spawn
@onready var mine_spawn = $mine_spawn
@onready var barrels_spawn = $barrels_spawn
@onready var prod_spawn = $production_line_spawn

@onready var comp_led = $GAMEUI/Map/ComputersRect
@onready var mine_led = $GAMEUI/Map/MineRect
@onready var barrels_led = $GAMEUI/Map/BarrelsRect
@onready var prod_led = $GAMEUI/Map/ProductionLineRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_ui.get_node("Points").text = "Points: "+str(robot.points)
	game_ui.get_node("Status").text = "Status: "+str(robot.status())
	game_ui.get_node("ErrorBar").size = Vector2(robot.error_timer.time_left/5.*1100,25)  # terribly hardcoded esto eh
	if not robot.alive:
		game_over.visible = true
	

func check_if_item_not_spawned(id, spawn_list):
	return not spawn_list[id].ItemSpawned


func _on_item_gen_timer_timeout() -> void:
	const ID_LIST = [0,1,2,3]
	if not (comp_spawn.ItemSpawned and
			mine_spawn.ItemSpawned and
			barrels_spawn.ItemSpawned and
			prod_spawn.ItemSpawned):
		var spawns = [comp_spawn, mine_spawn, barrels_spawn, prod_spawn]
		var ui_leds = [comp_led,mine_led,barrels_led,prod_led]
		var available_spawns = ID_LIST.filter(func(id): return check_if_item_not_spawned(id, spawns))
		var id_spawn = available_spawns.pick_random()
		
		var spawner = spawns[id_spawn]
		var led = ui_leds[id_spawn]
		
		spawner.spawn_item()

		
	else:
		$GameOver.show()
