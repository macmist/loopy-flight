extends Node2D

var is_alive: bool = true
var game_started: bool = false
var can_loop: bool = false

export var speed = 400
export var rotation_speed = 10


var start_transform

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	Signals.connect("killplayer", self, "playerDeath")
	Signals.connect("gamestarted", self, "gameStarted")
	Signals.connect("gamerestarted", self, "gameRestarted")
	Signals.connect("rotationstart", self, "enableLoop")
	Signals.connect("startplaneanim", self, "startAnim")
	$Animation.connect("animation_finished", self, "animationDone")
	$Animation.play("Start")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_loop:
		rotation -= delta * rotation_speed # rotate backward
	if game_started:	
		var velocity = Vector2()  # The player's movement vector.
		if is_alive:
			if Input.is_action_pressed("ui_down"):
				velocity.y += 1
			if Input.is_action_pressed("ui_up"):
				velocity.y -= 1
		else:
			velocity.y += 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta
		position.y = clamp(position.y, 0, screen_size.y - 10)

func playerDeath():
	is_alive = false
	
func gameStarted():
	game_started = true
	is_alive = true
	
func gameRestarted():
	transform = start_transform
	$Player.show()
	is_alive = true
	game_started = true
	
func animationDone(anim):
	var message
	if anim == "Start":
		message = "planearrived"
	if anim == "Half-Loop":
		message = "halfloop"
	if anim == 'End-Loop':
		message = "endloop"
	Signals.emit_signal("planeanimdone", message)

func enableLoop():
	start_transform = transform
	can_loop = true
	
func startAnim(name):
	if name == "halfloop":
		$Animation.play("Half-Loop")
	if name == "endloop":
		$Animation.play("End-Loop")


func _on_Timer_timeout():
	if game_started and is_alive:
		Signals.emit_signal("rewardplayer", 1)
