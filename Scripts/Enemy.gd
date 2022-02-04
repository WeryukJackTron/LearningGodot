extends KinematicBody2D

onready var player = get_node("/root/World/Area2D/Player/Player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 200
var flipped = false
var jump = false
var timer = 5
var maxjump = 0
var direction = Vector2()
var attack = false
var alive = true
export var roam = 200
var direction_facing = 1

func _ready():
	$AnimatedSprite.play("Walking")

func _process(delta):
	var tiempo = get_parent().get_node("../../GM").getTime()
	if tiempo >= 0.49 && tiempo < 0.79:
		get_node("AnimatedSprite2").visible = true
	else:
		get_node("AnimatedSprite2").visible = false

func _physics_process(delta):
	get_parent().get_node("CollisionShape2D").global_position = global_position
	if player && alive:
		if !player.getPause():
			$AnimatedSprite.play("Walking")
			$AnimatedSprite2.play("Walking")
			if attack:
				if $Head.is_colliding():
					player.pushUp()
					$DeathSound.play()
					$AnimatedSprite.play("Dead")
					$AnimatedSprite2.play("Dead")
					alive = false
					yield(get_tree().create_timer(0.8), "timeout")
					queue_free()
				if jump && global_position.y > maxjump:
					yield(get_tree().create_timer(0.1), "timeout")
					direction.y -= 35
				elif jump:
					jump = false
				if player.global_position.x > global_position.x:
					if $Right.is_colliding():
						direction.x = 0
					else:
						direction.x = speed
				elif player.global_position.x < global_position.x:
					if $Left.is_colliding():
						direction.x = 0
					else:
						direction.x = -speed
				if direction.x >= 0 && !flipped:
					flipped = true
					$AnimatedSprite.flip_h = flipped
					$AnimatedSprite2.flip_h = flipped
				elif direction.x < 0 && flipped:
					flipped = false
					$AnimatedSprite.flip_h = flipped
					$AnimatedSprite2.flip_h = flipped
				if !$Floor.is_colliding() && !jump:
					if alive:
						$AnimatedSprite.play("Falling")
						$AnimatedSprite2.play("Falling")
					direction.y += 30
				elif $Floor.is_colliding() && !jump:
					if $Floor.get_collider().name == "Spike":
						if alive:
							$DeathSound.play()
						alive = false
						$AnimatedSprite.play("Dead")
						$AnimatedSprite2.play("Dead")
						yield(get_tree().create_timer(0.2), "timeout")
						queue_free()
					jump = true
					if alive:
						$JumpingSound.play()
						$AnimatedSprite.play("Jump")
						$AnimatedSprite2.play("Jump")
					direction.y = 0
					maxjump = global_position.y - 30
				move_and_slide(direction)
			else:
				if $Head.is_colliding():
					player.pushUp()
					$DeathSound.play()
					$AnimatedSprite.play("Dead")
					$AnimatedSprite2.play("Dead")
					alive = false
					yield(get_tree().create_timer(0.8), "timeout")
					queue_free()
				if ($Right.is_colliding() || !$Right_ledge.is_colliding()) && direction_facing == 1:
					direction.x = -10
					direction_facing = -1
				elif ($Left.is_colliding() || !$Left_ledge.is_colliding()) && direction_facing == -1:
					direction.x = 10
					direction_facing = 1
				else:
					if $AnimatedSprite.frame < 2:
						direction.x = (speed/2) * direction_facing
					else:
						direction.x = 25 * direction_facing
				if direction.x >= 0 && !flipped:
					flipped = true
					$AnimatedSprite.flip_h = flipped
					$AnimatedSprite2.flip_h = flipped
				elif direction.x < 0 && flipped:
					flipped = false
					$AnimatedSprite.flip_h = flipped
					$AnimatedSprite2.flip_h = flipped
				if !$Floor.is_colliding():
					direction.y += 30
				else:
					direction.y = 0
				move_and_slide(direction)
		else:
			attack = false
			$AnimatedSprite.play("default")
			$AnimatedSprite2.play("default")
	elif !alive:
		direction.x = 0
		if !$Floor.is_colliding():
			direction.y += 30
		else:
			direction.y = 0
		move_and_slide(direction)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		attack = true
