extends TextureProgressBar


@export var player: Player

func _ready():
	update()
	if player:
		player.health_changed.connect(update)

func update():
	value = player.health * 100 / player.MAX_HP
