extends Marker3D
const ITEM = preload("res://scenes/Item.tscn")
var Name: String
var ItemSpawned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ItemSpawned = false

func spawn_item() -> void:
	var item = ITEM.instantiate()
	add_child(item)
	$DecayTimer.start()
	Globals.led_status[Name] = 1
	ItemSpawned = true

func item_grab() -> void:
	ItemSpawned = false
	$DecayTimer.stop()
	Globals.led_status[Name] = 0
	

func _on_decay_timer_timeout() -> void:
	Globals.led_status[Name] += 1
	$DecayTimer.start()

	
