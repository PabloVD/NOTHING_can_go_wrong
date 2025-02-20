extends Node3D

var parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("robot"):
		if not body.has_item:
			parent.item_grab()
			body.get_item()
			queue_free()
