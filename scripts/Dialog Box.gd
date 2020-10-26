extends Node2D

# List of dialog to be displayed one after the other
export var dialogs = ["Ah, another dumb endless runner. Or flyer in this case? That's my luck.",
"At least I'm flying straight"]

# The signal to send once all dialogs are shown
export var signal_string = "first"
var current_length
var page = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	getNextDialog()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if $Dialog.visible_characters < current_length:
		$Dialog.visible_characters += 1


func _on_Button_pressed():
	if $Dialog.visible_characters >= current_length:
		getNextDialog()
	else:
	   $Dialog.visible_characters = current_length

func getNextDialog():
	if page < dialogs.size() - 1:
		page += 1
		$Dialog.text = dialogs[page]
		current_length = dialogs[page].length()
		$Dialog.visible_characters = 0
	else:
		Signals.emit_signal("dialogfinished", signal_string)
		queue_free()
