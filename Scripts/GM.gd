extends Node2D

export (Gradient) var daylight_gradient

onready var canvas : CanvasModulate = get_node("../CanvasModulate")

var time = 0
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if !stop:
		time += 0.001
	
	if time > 1:
		time = 0
	
	canvas.color = daylight_gradient.interpolate(time)

func getTime():
	return time
