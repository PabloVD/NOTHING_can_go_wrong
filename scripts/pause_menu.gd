extends Control

func _ready() -> void:
	visible = false
	
	if DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_FULLSCREEN:
		$Fullscreen.button_pressed = true
	elif DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_WINDOWED:
		$Fullscreen.button_pressed = false
		
func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UIMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
