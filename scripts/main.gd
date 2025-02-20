extends Node3D

var points := 0
@onready var game_ui: Control = $GameUI
@onready var robot: CharacterBody3D = $Robot
@onready var game_over: Control = $GameOver

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
	
