# idle_state.gd - El personaje está quieto esperando input
class_name IdleState
extends State

func enter() -> void:
	player.velocity.x = 0
	player.get_node("AnimatedSprite2D").play("idle")

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Move")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
