extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProductionLineRect.change_color(Globals.led_status['production'])
	$BarrelsRect.change_color(Globals.led_status['barrel'])
	$MineRect.change_color(Globals.led_status['mine'])
	$ComputersRect.change_color(Globals.led_status['computer'])
