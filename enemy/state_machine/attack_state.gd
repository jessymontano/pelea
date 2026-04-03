extends EnemyState

@export var enemy: Enemy

@onready var hitbox_collision = enemy.get_node("Pivot/Hitbox/CollisionShape2D")

func enter():
	enemy.velocity = Vector2.ZERO
	var ataque = randi_range(1, 2)
	
	match ataque:
		1: enemy.animated_sprite.play("attack_1")
		2: enemy.animated_sprite.play("attack_2")
			
	if not enemy.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.animated_sprite.animation_finished.connect(_on_animation_finished)

func update(_delta: float):
	if enemy.animated_sprite.frame == 4:
		hitbox_collision.disabled = false
	else:
		hitbox_collision.disabled = true
	
func _on_animation_finished():
	var current_anim = enemy.animated_sprite.animation
	if current_anim.begins_with("attack_"):
		transitioned.emit(self, "CooldownState")

func exit():
	if enemy.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.animated_sprite.animation_finished.disconnect(_on_animation_finished)
