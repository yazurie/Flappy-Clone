extends Node2D

onready var GameOver = get_node("CanvasLayer/gameover")
onready var Background = get_node("ParallaxBackground/background")
onready var result = get_node("CanvasLayer/result")
onready var playbutton = get_node("CanvasLayer/Playbutton")
onready var scorebordbutton = get_node("CanvasLayer/Scorebutton")
onready var Player = get_node("Player")
onready var Score = get_node("CanvasLayer/Score")
onready var message = get_node("CanvasLayer/message")


var restart = false
var fadespeed = 0.045
var fadein = false

var bronzescore = preload("res://Files/bronzescore.png")
var silverscore = preload("res://Files/silverscore.png")
var goldscore = preload("res://Files/goldscore.png")
var platinscore = preload("res://Files/platinscore.png")
var day = preload("res://Files/background-day.png")
var night = preload("res://Files/background-night.png")

var save_path = "user://Highscore.encryptethismyguysbecauseithinkyoucantbutifyouwannatrieyousurecando"
var Pipe = preload("res://pipe.tscn")
var Pipeposition = [-50, -40, -30, -20, -10, 0, 10, 20 ,30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140 ]
var Highscore = {
	"HighScore": 0
	}


func _ready():
	load_data()
	var randomn = get_tree().get_root().get_node("/root/GlobalTheme").randomtheme
	if randomn == 1:
		Player.get_node("AnimatedSprite").play("flapyellow")
		$ParallaxBackground/background.texture = day
	if randomn == 2:
		Player.get_node("AnimatedSprite").play("flapred")
		$ParallaxBackground/background.texture = day
	if randomn == 3:
		Player.get_node("AnimatedSprite").play("flapred")
		$ParallaxBackground/background.texture = night
	if randomn == 4:
		Player.get_node("AnimatedSprite").play("flapblue")
		$ParallaxBackground/background.texture = night


func _physics_process(delta):
	if fadein == false:
		if Score.modulate.r < 1:
			Background.modulate.r += 0.1
			Background.modulate.g += 0.1
			Background.modulate.b += 0.1
			
			message.modulate.r += 0.1
			message.modulate.g += 0.1
			message.modulate.b += 0.1
			Score.modulate.r += 0.1
			Score.modulate.g += 0.1
			Score.modulate.b += 0.1
			modulate.r += 0.1
			modulate.g += 0.1
			modulate.b += 0.1
		if Background.modulate.r == 1:
			fadein = true
			
			
			
			
	
	
	
	
	
	
	
	
	if restart == true:
		GameOver.modulate.r -= fadespeed
		GameOver.modulate.g -= fadespeed
		GameOver.modulate.b -= fadespeed
		Background.modulate.r -= fadespeed
		Background.modulate.g -= fadespeed
		Background.modulate.b -= fadespeed
		result.modulate.r -= fadespeed
		result.modulate.g -= fadespeed
		result.modulate.b -= fadespeed
		playbutton.modulate.r -= fadespeed
		playbutton.modulate.g -= fadespeed
		playbutton.modulate.b -= fadespeed
		scorebordbutton.modulate.r -= fadespeed
		scorebordbutton.modulate.g -= fadespeed
		scorebordbutton.modulate.b -= fadespeed
		modulate.r -= fadespeed
		modulate.g -= fadespeed
		modulate.b -= fadespeed

func save_data():
	var save_game = File.new()
	save_game.open_encrypted_with_pass(save_path, File.WRITE, "123")
	save_game.store_line(to_json(Highscore))
	save_game.close()
	
func load_data():
	var save_game = File.new()
	if not save_game.file_exists(save_path):
		print("No data found... Create new one")
		save_data()
		return
	
	save_game.open_encrypted_with_pass(save_path, File.READ, "123")
	Highscore = parse_json(save_game.get_line())

func _on_Timer_timeout():
	if get_node("Player").start == true:
		var positionP = get_node("Player").position
		var Pipe_spawn = Pipe.instance()
		var Pipepositiony = randi() % Pipeposition.size() 
		Pipe_spawn.position.x = positionP.x + 535
		Pipe_spawn.position.y = Pipeposition[Pipepositiony]
		get_node("pipespawn").add_child(Pipe_spawn)
	


func _on_Playbutton_pressed():
	restart = true
	print("ok")
	get_node("Player/smooosh").play()
	$Replay.start()

func _on_Player_Death():
	if get_node("Player").gamescore >= 10 and get_node("Player").gamescore <20:
		print("Hmm")
		$CanvasLayer/result/Medallion.texture = bronzescore
	if get_node("Player").gamescore >= 20 and get_node("Player").gamescore <30:
		$CanvasLayer/result/Medallion.texture = silverscore
	if get_node("Player").gamescore >= 30 and get_node("Player").gamescore <40:
		$CanvasLayer/result/Medallion.texture = goldscore
	if get_node("Player").gamescore >= 40:
		$CanvasLayer/result/Medallion.texture = platinscore


func _on_Replay_timeout():
	get_tree().reload_current_scene()

