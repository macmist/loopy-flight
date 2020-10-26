extends KinematicBody2D


export var jump_velocity = 1050.0
export var gravity_scale = 20.0
export var speed = 400.0
export var rotation_speed = 20

onready var animation = $AnimatedSprite
onready var crash = $Crash
onready var fly = $Flying
onready var engine = $EngineParticles
onready var explostion = $Explosion

export (NodePath) var path_to_target;
var target

var can_jump : bool = true

var is_alive : bool = true

var score = 0

var screen_size


func _ready():
	target = get_parent()
	
	# get the screen size
	screen_size = get_viewport_rect().size	
	
	# Register for signals
	Signals.connect("killplayer", self, "killPlayer")
	Signals.connect("rewardplayer", self, "rewardPlayer")
	Signals.connect("gamestarted", self, "init")
	Signals.connect("gamerestarted", self, "init")

	init()

# when something enter the area below the player
func _on_Area2D_body_entered(body):
	pass


# when something exits the area below the player
func _on_Area2D_body_exited(body):
	pass

# kills the player
func killPlayer():
	if is_alive:
		is_alive = false
		fly.stop()
		crash.play()
		engine.emitting = false
		explostion.emitting = true
		yield(crash, "finished")
		Signals.emit_signal("gameover")
		hide()

# Add to the player score
func rewardPlayer(scoreToAdd):
	score += scoreToAdd
	Signals.emit_signal("updatedscore", score)

# Init 
func init():
	is_alive = true
	fly.play()
	# Play our only animation
	animation.play("Fly")
	score = 0


