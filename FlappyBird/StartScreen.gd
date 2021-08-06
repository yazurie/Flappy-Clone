extends Node2D

var start = false

onready var Background = get_node("ParallaxBackground/background")
onready var Rate = get_node("CanvasLayer/Rate")
onready var playbutton = get_node("CanvasLayer/Play")
onready var scorebordbutton = get_node("CanvasLayer/Scoreboard")
onready var Flappybird = get_node("CanvasLayer/FlappyBird")
onready var Flapyrights = get_node("CanvasLayer/flappyrights")

var fadespeed = 0.045

func _physics_process(delta):
	
	
	if start == true:
		Rate.modulate.r -= fadespeed
		Rate.modulate.g -= fadespeed
		Rate.modulate.b -= fadespeed
		Background.modulate.r -= fadespeed
		Background.modulate.g -= fadespeed
		Background.modulate.b -= fadespeed
		playbutton.modulate.r -= fadespeed
		playbutton.modulate.g -= fadespeed
		playbutton.modulate.b -= fadespeed
		scorebordbutton.modulate.r -= fadespeed
		scorebordbutton.modulate.g -= fadespeed
		scorebordbutton.modulate.b -= fadespeed
		Flappybird.modulate.r -= fadespeed
		Flappybird.modulate.g -= fadespeed
		Flappybird.modulate.b -= fadespeed
		Flapyrights.modulate.r -= fadespeed
		Flapyrights.modulate.g -= fadespeed
		Flapyrights.modulate.b -= fadespeed
		modulate.r -= fadespeed
		modulate.g -= fadespeed
		modulate.b -= fadespeed

func _on_Play_pressed():
	$woosh.play()
	$Player/Play.start()
	start = true


func _on_Play_timeout():
	get_tree().change_scene("res://Main.tscn")
