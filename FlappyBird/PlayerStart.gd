extends KinematicBody2D




var motion = Vector2()
var day = preload("res://Files/background-day.png")
var night = preload("res://Files/background-night-start.png")

var start = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("/root/GlobalTheme").randomnumber()
	var randomn = get_tree().get_root().get_node("/root/GlobalTheme").randomtheme
	if randomn == 1:
		$AnimatedSprite.play("flapyellow")
		get_parent().get_node("ParallaxBackground/background").texture = day
	if randomn == 2:
		$AnimatedSprite.play("flapred")
		get_parent().get_node("ParallaxBackground/background").texture = day
	if randomn == 3:
		$AnimatedSprite.play("flapred")
		get_parent().get_node("ParallaxBackground/background").texture = night
	if randomn == 4:
		$AnimatedSprite.play("flapblue")
		get_parent().get_node("ParallaxBackground/background").texture = night
	motion.x = 120
	motion.y = 20

func _physics_process(delta):
	move_and_slide(motion, Vector2.UP)
	


func _on_Timer_timeout():
	motion.y = -motion.y




func _on_Play_timeout():
	get_tree().change_scene("res://Main.tscn")
