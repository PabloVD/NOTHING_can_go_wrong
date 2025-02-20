extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("robot"):
		if body.has_item:
			body.drop_item()
			body.points += 1
			# Start to present errors first time that an item is delivered
			if body.points==1:
				body.start_failing()
