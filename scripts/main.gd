extends Node3D

var points := 0
@onready var game_ui: Control = $GameUI
@onready var robot: CharacterBody3D = $Robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_ui.get_node("Points").text = "Points: "+str(robot.points)
