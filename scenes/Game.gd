extends Node2D

export (PackedScene) var dialog
export (PackedScene) var loop_prompt

func _ready():
	randomize()
	Signals.connect("dialogfinished",self, "dialogDone")
	Signals.connect("planeanimdone", self, "animDone")
	Signals.connect("gameover", self, "gameOver")
	
	
func startDialog(name):
	var tmp = dialog.instance()
	if name == "halfloop":
		tmp.dialogs = ["Just so you know, I think this was a terrible idea..."]
		tmp.signal_string = "halfloop"
	if name == "endloop":
		tmp.dialogs = ["Aaaaand it's stuck.",
		 "Told you it was a bad idea!", 
		"The theme was \"stuck in a loop\", what did you expect?", "Well, now it's my time to shine I guess...",
		"Let's start this game, that intro was waaay too long."]
		tmp.signal_string = name
	add_child_below_node(self, tmp)

func animDone(name):
	if name == "endloop":
		Signals.emit_signal("rotationstart")
		yield(get_tree().create_timer(1.0), "timeout")
	startDialog(name)

func dialogDone(name):
	if name == "first":
		$"Loop prompt".show()
	if name == "halfloop":
		Signals.emit_signal("startplaneanim", "endloop")
	if name == "endloop":
		$Menu.show()

func gameOver():
	# Clear any remaining item then show the menu
	get_tree().call_group("items", "queue_free")
	$Menu.show()
