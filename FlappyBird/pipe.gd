extends StaticBody2D

var greenpipe = preload("res://Files/pipe-green.png")
var redpipe = preload("res://Files/pipe-red.png")

func _ready():
	var randomn = get_tree().get_root().get_node("/root/GlobalTheme").randomtheme
	if randomn == 1:
		$pipedown.texture = greenpipe
		$pipeup.texture = greenpipe
	if randomn == 2:
		$pipedown.texture = greenpipe
		$pipeup.texture = greenpipe
	if randomn == 3:
		$pipedown.texture = redpipe
		$pipeup.texture = redpipe
	if randomn == 4:
		$pipedown.texture = redpipe
		$pipeup.texture = redpipe

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
