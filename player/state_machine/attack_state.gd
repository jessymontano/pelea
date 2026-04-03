# attack_state.gd
class_name AttackState
extends State

func enter() -> void:
	player.velocity.x = 0
	var anim: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
	anim.play("attack")
	if not anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	var anim: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
	if anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished() -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Move")
	else:
		state_machine.transition_to("Idle")
