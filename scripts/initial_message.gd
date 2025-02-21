extends Control
@onready var greetings: Control = $Greetings
@onready var tutorial: Control = $Tutorial

func _on_proceed_pressed() -> void:
	greetings.visible = false
	tutorial.visible = true

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/World.tscn")
