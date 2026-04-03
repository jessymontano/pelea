# dead_state.gd - El personaje muere (estado final, no responde a controles)
class_name DeadState
extends State

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.get_node("Pivot/AnimatedSprite2D").play("dead")
	# Deshabilitar input y física
	player.set_physics_process(false)
	player.set_process_input(false)

func exit() -> void:
	pass

# Estado final: sin transiciones
