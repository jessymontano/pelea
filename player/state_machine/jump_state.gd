extends State
class_name JumpState

const JUMP_FORCE := -500.0
var _frames_since_enter := 0

func enter() -> void:
	player.velocity.y = JUMP_FORCE
	player.get_node("Pivot/AnimatedSprite2D").play("jump")
	_frames_since_enter = 0

func handle_input(_event: InputEvent) -> void:
	pass

func physics_update(_delta: float) -> void:
	_frames_since_enter += 1

	var direction := 0
	if Input.is_action_pressed("move_left"):
		direction = -1
		player.get_node("Pivot").scale.x = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1
		player.get_node("Pivot").scale.x = 1

	if direction != 0:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

	if _frames_since_enter > 3 and player.is_on_floor():
		if direction != 0:
			state_machine.transition_to("Move")
		else:
			state_machine.transition_to("Idle")
