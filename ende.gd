extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_parent().end()
		
func die():
	pass
		
