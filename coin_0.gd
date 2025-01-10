extends AnimatedSprite2D

var coin_is_da = true
var coin_collected = false

func _process(delta: float) -> void:
	if coin_collected == true:
		play("Coin WEG")
	elif coin_is_da == true:
		play("Coin")
	else:
		play("Coin Collect")
		coin_collected = true

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	coin_is_da = false

func die():
	pass
