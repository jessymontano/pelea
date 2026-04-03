extends EnemyState

@export var enemy: Enemy
@export var wait_time: float = 3.0
var timer: float = 0.0

func enter():
	enemy.velocity = Vector2.ZERO
	enemy.animated_sprite.play("idle") 
	timer = wait_time

func update(delta: float):
	timer -= delta
	if timer <= 0:
		transitioned.emit(self, "ChaseState")
