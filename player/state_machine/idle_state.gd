extends State
class_name IdleState

func enter() -> void:
	player.velocity.x = 0
	player.get_node("Pivot/AnimatedSprite2D").play("idle")

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Move")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		print("transicion a jump")
		state_machine.transition_to("Jump")
