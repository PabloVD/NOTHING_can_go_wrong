extends ColorRect

const LEVEL0_COLOR = Color(0.282,0.169, 0.137, 0.573)
const LEVEL1_COLOR = Color(0.371,0.588, 0.2, 1)
const LEVEL2_COLOR = Color(1,0.77, 0, 1)
const LEVEL3_COLOR = Color(0.811,0.33, 0.14, 1)


# turns on the led on the minimap
func change_color(level):
	if level == 0:
		set_color(LEVEL0_COLOR)
	elif level == 1:
		set_color(LEVEL1_COLOR)
	elif level == 2:
		set_color(LEVEL2_COLOR)
	elif level == 3:
		set_color(LEVEL3_COLOR)
	
