extends Area2D




func _on_Key_body_entered(body):
	if body.name == "Player":
		queue_free()


func _on_Coin_body_entered(body):
	if body.name == "Player":
		queue_free()
