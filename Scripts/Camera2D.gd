extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var l_left = 516
var l_right = 8600
var l_top = -80
var originaly = 212
var clock = 0

func _process(delta):
	var aux = ""
	if !get_parent().get_node("Player").getPause():
		clock += delta
	for i in (6 - str(int(round(clock))).length()):
		aux += "0"
	aux += str(int(round(clock)))
	get_node("Clock").text = aux
	get_node("Clock2").text = aux

func updateCamera(char_pos, time):
	if char_pos.x < l_left:
		global_position.x = l_left
	elif char_pos.x > l_right:
		global_position.x = l_right
	else:
		global_position.x = char_pos.x
	if char_pos.y < l_top:
		if global_position.y < l_top-8:
			global_position.y += 8
		elif global_position.y > l_top+8:
			global_position.y -= 8
	else:
		if global_position.y < originaly:
			global_position.y += 8
	if time >= 0.44 && time < 0.79:
		get_node("Coins").visible = true
		get_node("Coins2").visible = false
		get_node("Keys2").visible = true
		get_node("Keys").visible = false
		get_node("Sprite2").visible = true
		get_node("Sprite").visible = false
		get_node("Sprite4").visible = true
		get_node("Clock2").visible = true
		get_node("Clock").visible = false
	else:
		get_node("Coins").visible = false
		get_node("Coins2").visible = true
		get_node("Keys2").visible = false
		get_node("Keys").visible = true
		get_node("Sprite2").visible = false
		get_node("Sprite").visible = true
		get_node("Sprite4").visible = false
		get_node("Clock2").visible = false
		get_node("Clock").visible = true

func restart(time):
	if time >= 0.45 && time < 0.78:
		get_node("Label").visible = !get_node("Label").visible
	else:
		get_node("Label2").visible = !get_node("Label2").visible
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
