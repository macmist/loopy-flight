extends Node2D

export (Array, PackedScene) var scenes
var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var game_started = false

func _ready():
	Signals.connect("gamestarted", self, "start")
	Signals.connect("gamerestarted", self, "start")
	Signals.connect("gameover", self, "stop")

# spawn a new random object each time the timer is finished
func _on_Timer_timeout():
	if game_started:
		random_scene.randomize()
		$Path2D/PathFollow2D.offset = randi()
		selected_scene_index = random_scene.randi_range(0, scenes.size() - 1)
		var tmp = scenes[selected_scene_index].instance()
		tmp.position = $Path2D/PathFollow2D.position
		add_child(tmp)
		
	
func start():
	game_started = true
	$Timer.start()
	
func stop():
	$Timer.stop()
	game_started = false
	
