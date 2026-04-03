# hit_state.gd - El personaje recibe daño (control bloqueado temporalmente)
class_name HitState
extends State

const HIT_DURATION := 0.6

var _timer := 0.0

func enter() -> void:
	_timer = 0.0
	player.velocity.x = 0
	player.get_node("AnimatedSprite2D").play("hit")

func exit() -> void:
	pass

func update(delta: float) -> void:
	_timer += delta
	if _timer >= HIT_DURATION:
		if player.health <= 0:
			state_machine.transition_to("Dead")
		else:
			state_machine.transition_to("Idle")
