extends EnemyState

@export var enemy: Enemy

func enter():
	enemy.velocity = Vector2.ZERO
	enemy.animated_sprite.play("death")
	
	if enemy.has_node("CollisionShape2D"):
		enemy.get_node("CollisionShape2D").set_deferred("disabled", true)
	
	if not enemy.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.animated_sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	if enemy.animated_sprite.animation == "death":
		enemy.queue_free()
