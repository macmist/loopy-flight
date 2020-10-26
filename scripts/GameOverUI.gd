extends Button

func _ready():
	pass



# reload the game from beginning
func _on_Button_pressed():
	Signals.emit_signal("gamerestarted")
	self.hide()

# Simply show the button on game over
func gameOver():
	self.show()
