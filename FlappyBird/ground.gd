extends TileMap

var xpos
var Newpos

func _ready():
	pass
	

func _physics_process(delta):
	xpos = world_to_map(get_parent().get_node("Player").position)
	if Newpos != xpos:
		Newpos = xpos
		set_cell(xpos.x + 1, -3, 0)
		set_cell(xpos.x - 3, -3, -1)
