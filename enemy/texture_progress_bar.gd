extends TextureProgressBar

@export var enemy: Enemy

func _ready():
	update()
	enemy.health_changed.connect(update)

func update():
	value = enemy.current_health * 100 / enemy.max_health
