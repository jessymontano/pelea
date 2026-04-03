extends EnemyState

@export var enemy: Enemy
@export var attack_range: float = 60.0

func physics_update(delta: float) -> void:
	if not enemy.player:
		return
	
	if not enemy.is_on_floor():
		enemy.velocity.y += enemy.gravity * delta
		
	var distance_to_player = abs(enemy.global_position.x - enemy.player.global_position.x)
	
	if distance_to_player <= attack_range:
		enemy.velocity.x = 0
		transitioned.emit(self, "AttackState")
	else:
		var direction = sign(enemy.player.global_position.x - enemy.global_position.x)
		enemy.velocity.x = direction * enemy.speed
		enemy.animated_sprite.play("walk")
		
		if direction > 0:
			enemy.get_node("Pivot").scale.x = 1
		elif direction < 0:
			enemy.get_node("Pivot").scale.x = -1
	
	enemy.move_and_slide()
