# attack_state.gd - El personaje ataca (no puede moverse durante el ataque)
class_name AttackState
extends State

func enter() -> void:
	player.velocity.x = 0
	var anim: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
	anim.play("attack")
	# Esperamos a que termine la animación para regresar a Idle
	if not anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	var anim: AnimatedSprite2D = player.get_node("AnimatedSprite2D")
	if anim.animation_finished.is_connected(_on_animation_finished):
		anim.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished() -> void:
	state_machine.transition_to("Idle")
