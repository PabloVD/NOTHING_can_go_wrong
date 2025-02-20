extends ColorRect
const ON_COLOR = Color(0.811,0.33, 0.14, 1)
const OFF_COLOR = Color(0.282,0.169, 0.137, 0.573)

# turns on the led on the minimap
func turn_on():
	set_color(ON_COLOR)
	
# turns off the led on the minimap
func turn_off():
	set_color(OFF_COLOR)
