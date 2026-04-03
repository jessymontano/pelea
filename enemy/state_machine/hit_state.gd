extends EnemyState

@export var enemy: Enemy

func enter():
	enemy.velocity = Vector2.ZERO
	enemy.animated_sprite.play("hurt")
	
	if not enemy.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.animated_sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	if enemy.animated_sprite.animation == "hurt":
		transitioned.emit(self, "ChaseState")

func exit():
	if enemy.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.animated_sprite.animation_finished.disconnect(_on_animation_finished)
