extends Control

@onready var mainmenu = $Menus/MainMenu
@onready var credits = $Menus/Credits
@onready var controls = $Menus/Controls
@onready var initial_message: Control = $InitialMessage
@onready var menus: Control = $Menus

func _ready() -> void:
	credits.visible = false
	controls.visible = false
	mainmenu.visible = true
	#$Menus/Fullscreen.button_pressed = true
	
	if DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_FULLSCREEN:
		$Menus/Fullscreen.button_pressed = true
	elif DisplayServer.window_get_mode()==DisplayServer.WINDOW_MODE_WINDOWED:
		$Menus/Fullscreen.button_pressed = false

func _on_play_pressed() -> void:
	initial_message.visible = true
	menus.visible = false

func _on_controls_pressed() -> void:
	controls.visible = true
	mainmenu.visible = false

func _on_credits_pressed() -> void:
	credits.visible = true
	mainmenu.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	credits.visible = false
	controls.visible = false
	mainmenu.visible = true

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
