extends Node3D

func _on_fail_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("robot"):
		print("Escoñao!")
		body.jump_failure()
		body.invert_direction()
		body.random_bugs()
