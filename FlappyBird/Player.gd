extends KinematicBody2D
#this comment isn't useful in any way 

var blink = false
var gravity = 950
var motion = Vector2()
var jumpforce = -300
var gamescore = 0
var Death = false
var maxrot = 90
var rotspeed = 4
var start = false
var resulshow = false
var resultscore = 0
onready var result = get_parent().get_node("CanvasLayer/result")
onready var jumpsfx = get_node("jump")

signal Death
func _ready():
	get_tree().get_root().get_node("/root/GlobalTheme").randomnumber()
	rotation_degrees = 0
	motion.y = 20
	motion.x = 120

func Input():
	if Input.is_action_just_pressed("jump") and position.y > -10 and Death == false:
		$AnimatedSprite.speed_scale = 2.5
		start = true
		rotation_degrees = -20
		motion.y = jumpforce
		jumpsfx.play()

func _physics_process(delta):
	
	Input()
	
	
	
	
	if start == true:
		$beginfly.stop()
		get_parent().get_node("CanvasLayer/message").modulate.a -= 0.05
		if motion.y < 500:
			motion.y += gravity * delta
			print(motion.y)
	if rotation_degrees < maxrot and start == true and motion.y > 200: 
		rotation_degrees += rotspeed
	move_and_slide(motion, Vector2.UP)
	
	
	
	
	
	if resulshow == true and result.position.y > 250:
		result.position.y -= 30
		print(result.position.y)
	
	if Death == true:
		if blink == false:
			get_parent().get_node("ParallaxBackground/background").modulate.a -= 0.3
			get_parent().get_node("pipespawn").modulate.a -= 0.9
			get_parent().get_node("CanvasLayer/Score").modulate.a -= 0.3
			get_parent().get_node("Boden").modulate.a -= 0.3
			modulate.a -= 0.3
		if get_parent().get_node("ParallaxBackground/background").modulate.a <= 0.01:
			get_parent().get_node("Boden").modulate.a = 1
			get_parent().get_node("ParallaxBackground/background").modulate.a = 1
			get_parent().get_node("pipespawn").modulate.a = 1
			get_parent().get_node("CanvasLayer/Score").modulate.a = 1
			
			modulate.a = 1
			blink = true
		#get_tree().reload_current_scene()
		maxrot = 90
		motion.x = 0
		$AnimatedSprite.stop()
		
		
		emit_signal("Death")
	
	if gamescore <= get_parent().Highscore.HighScore:
		get_parent().get_node("CanvasLayer/result/Highscore").set_text(str(get_parent().Highscore.HighScore))
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == get_parent().get_node("Boden") and Death == false:
			
			Death = true
			$resultanimation.start()
			$playanimation.start()
			$Hit.play()
			
		else:
			if Death == false:
				set_collision_layer_bit(1, false) 
				rotspeed = 5
				Death = true
				
				$resultanimation.start()
				$playanimation.start()
				$die.play()
				$Hit.play()



	 
func _on_Area2D_area_entered(area):
	if Death == false:
		gamescore += 1
		get_parent().get_node("CanvasLayer/Score").set_text(str(gamescore))
		$Score.play()





func _on_Hitpipe_finished():
	get_parent().get_node("CanvasLayer/Score").visible = false
	get_parent().get_node("CanvasLayer/gameover").visible = true
	$smooosh.play()


func _on_beginfly_timeout():
	if start == false:
		motion.y = -motion.y




func _on_resultanimation_timeout():
	get_parent().get_node("CanvasLayer/result").visible = true
	$smooosh.play()
		
	resulshow = true


func _on_playanimation_timeout():
	if gamescore == 0:
		get_parent().get_node("resultscoreUP").wait_time = 0.01
	if gamescore != 0:
		get_parent().get_node("resultscoreUP").wait_time = float(1) / float(gamescore * 2)
	get_parent().get_node("resultscoreUP").start()
	
	print(get_parent().get_node("resultscoreUP").wait_time)


func _on_resultscoreUP_timeout():
	if resultscore < gamescore:
		resultscore += 1
		get_parent().get_node("CanvasLayer/result/Score").set_text(str(resultscore))
		#get_parent().get_node("CanvasLayer/result/Highscore").set_text(str(get_parent().Highscore.HighScore))
	if resultscore == gamescore:
		if gamescore > get_parent().Highscore.HighScore:
			get_parent().Highscore.HighScore = gamescore
			get_parent().save_data()
			get_parent().get_node("CanvasLayer/result/NewHighScore").visible = true
		get_parent().get_node("CanvasLayer/Playbutton").visible = true
		get_parent().get_node("CanvasLayer/Scorebutton").visible = true
		
		get_parent().get_node("resultscoreUP").stop()
	
