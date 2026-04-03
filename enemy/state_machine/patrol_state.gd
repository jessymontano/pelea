extends EnemyState

@export var enemy: Enemy
@export var patrol_speed: float = 50.0
@export var patrol_points: Array[Marker2D]

var target_point_index: int = 0

func enter():
	enemy.animated_sprite.play("walk") 

func physics_update(_delta: float):
	print("ola")
	if patrol_points.size() < 2:
		return

	var target = patrol_points[target_point_index].global_position
	var direction = enemy.global_position.direction_to(target)
	
	enemy.velocity.x = direction.x * patrol_speed
	enemy.move_and_slide()
	
	if direction.x > 0:
		enemy.get_node("Pivot").scale.x = 1
	elif direction.x < 0:
		enemy.get_node("Pivot").scale.x = -1

	if enemy.global_position.distance_to(target) < 10.0:
		target_point_index = (target_point_index + 1) % patrol_points.size()

	if can_see_player():
		transitioned.emit(self, "ChaseState")

func can_see_player() -> bool:
	if not enemy.player: return false
	var dist = enemy.global_position.distance_to(enemy.player.global_position)
	return dist < 200.0
