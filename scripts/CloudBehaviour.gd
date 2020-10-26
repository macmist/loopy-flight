extends "ScrollMovement.gd"

func _physics_process(delta):
	move()


# delete the object once it is off screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Obstacle_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("rewardplayer", 5)
		queue_free()
		
