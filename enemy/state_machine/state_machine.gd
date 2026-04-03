extends Node
class_name EnemyStateMachine


@export var initial_state: EnemyState
var current_state: EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is EnemyState:
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		
func on_child_transition(state: EnemyState, new_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state = get_node_or_null(new_state_name)
	if !new_state:
		return
	
	current_state.exit()
	new_state.enter()
	current_state = new_state
