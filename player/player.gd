extends CharacterBody2D
class_name Player

const SPEED  := 180.0
const MAX_HP := 100

var health: int = MAX_HP

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var sm: Node               = $StateMachine

func _ready() -> void:
	# le pasamos la referencia del player a cada estado
	for state in sm.get_children():
		state.player        = self
		state.state_machine = sm
	
	# empezamos en idle
	sm.init(sm.get_node("Idle"))


func take_damage(amount: int) -> void:
	# si ya estamos muertos no hacemos nada
	if sm.current_state == sm.get_node("Dead"):
		return
	
	health -= amount
	health  = max(health, 0)
	print("HP: ", health)
	sm.transition_to("Hit")


func _input(event: InputEvent) -> void:
	sm.handle_input(event)
	
	# descomentar para probar daño y muerte con teclado
	#if Input.is_action_just_pressed("ui_page_up"):
		#take_damage(25)
	#if Input.is_action_just_pressed("ui_page_down"):
		#take_damage(200)


func _process(delta: float) -> void:
	sm.update(delta)


func _physics_process(delta: float) -> void:
	sm.physics_update(delta)
	move_and_slide()
	
	# evitar que el jugador se salga de la pantalla
	position.x = clamp(position.x, 40, 1112)
