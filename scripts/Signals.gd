extends Node2D

# Signals used in the whole game
signal killplayer
signal rewardplayer
signal updatedscore
signal gameover
signal gamestarted
signal gamerestarted


signal startplaneanim # signal to start a plane animation
signal planeanimdone # signal when an animation is finished
signal dialogfinished #signal when a dialog is finished

signal rotationstart # Signal to start the plane infinite loop



# Signals for the dialog box
signal introfinished


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


