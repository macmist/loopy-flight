extends Node2D

export var min_scroll_speed = 5.0
export var max_scroll_speed = 8.0

var scroll_speed 


func _ready():
	scroll_speed = rand_range(min_scroll_speed, max_scroll_speed)
	
func move():
	self.position.x -= scroll_speed
