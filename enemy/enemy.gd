extends CharacterBody2D
class_name Enemy

@export var speed: float = 100.0
@export var max_health: int = 100
@export var attack_damage: int = 20

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_health: int
var player: Node2D

@onready var animated_sprite = $Pivot/AnimatedSprite2D
@onready var state_machine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health
	player = get_tree().get_first_node_in_group("Player")
	
	for state in state_machine.get_children():
		if "enemy" in state:
			state.enemy = self

func take_damage(amount: int):
	current_health -= amount
	flash_red()
	if current_health <= 0:
		$StateMachine.on_child_transition($StateMachine.current_state, "DeadState")
	else:
		$StateMachine.on_child_transition($StateMachine.current_state, "HitState")
		
# parpadear rojo cuando le pegan
func flash_red():
	var tween = create_tween()
	animated_sprite.modulate = Color(1, 0, 0)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1), 0.2)

# atacar jugador
func _on_hitbox_body_entered(body: Node2D) -> void:
	print("ataco a alguien")
	print(body.name)
	if body.is_in_group("Player") and body.has_method("take_damage"):
		body.take_damage(attack_damage)
