extends State
class_name MoveState

func enter() -> void:
	player.get_node("AnimatedSprite2D").play("walk")

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")

func physics_update(_delta: float) -> void:
	var direction := 0
	if Input.is_action_pressed("move_left"):
		direction = -1
		player.get_node("AnimatedSprite2D").flip_h = true
	elif Input.is_action_pressed("move_right"):
		direction = 1
		player.get_node("AnimatedSprite2D").flip_h = false

	if direction == 0:
		state_machine.transition_to("Idle")
		return

	player.velocity.x = direction * player.SPEED
