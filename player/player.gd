extends CharacterBody2D
class_name Player

const SPEED   := 180.0
const GRAVITY := 980.0
const MAX_HP  := 100

var health: int = MAX_HP
@export var attack_damage: int = 20

@onready var anim: AnimatedSprite2D = $Pivot/AnimatedSprite2D
@onready var sm: Node               = $StateMachine

func _ready() -> void:
	for state in sm.get_children():
		state.player        = self
		state.state_machine = sm
	sm.init(sm.get_node("Idle"))

func take_damage(amount: int) -> void:
	if sm.current_state == sm.get_node("Dead"):
		return
	flash_red()
	health -= amount
	health  = max(health, 0)
	print("HP: ", health)
	sm.transition_to("Hit")

# parpadear rojo cuando le pegan
func flash_red():
	var tween = create_tween()
	anim.modulate = Color(1, 0, 0)
	tween.tween_property(anim, "modulate", Color(1, 1, 1), 0.2)

func _input(event: InputEvent) -> void:
	sm.handle_input(event)

func _process(_delta: float) -> void:
	sm.update(_delta)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	sm.physics_update(delta)
	move_and_slide()
	position.x = clamp(position.x, 40, 1112)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
