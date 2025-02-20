extends Marker3D
const ITEM = preload("res://scenes/Item.tscn")
var ItemSpawned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ItemSpawned = false

func spawn_item() -> void:
	var item = ITEM.instantiate()
	add_child(item)
	ItemSpawned = true

func item_grab() -> void:
	ItemSpawned = false
