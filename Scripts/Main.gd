extends YSort

onready var player = $Player

func _ready():
	if Globals.last_position:
		player.global_position = Globals.last_position
