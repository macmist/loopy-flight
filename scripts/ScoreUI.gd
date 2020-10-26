extends Label

var default_text
# Register for score signal
func _ready():
	Signals.connect("updatedscore", self, "updateScore")
	Signals.connect("gamestarted", self, "init")
	Signals.connect("gamerestarted", self, "init")
	default_text = text
	
# Updates the score displayed on screen
func updateScore(score):
	self.text = String(score)
	
func init():
	text = default_text
