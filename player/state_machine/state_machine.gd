# state_machine.gd - Controlador de la máquina de estados
extends Node

var current_state: State

func init(starting_state: State) -> void:
	current_state = starting_state
	current_state.enter()

func transition_to(state_name: String) -> void:
	var new_state = get_node_or_null(state_name)
	if new_state == null:
		push_error("Estado no encontrado: " + state_name)
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()

func handle_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func update(delta: float) -> void:
	current_state.update(delta)

func physics_update(delta: float) -> void:
	current_state.physics_update(delta)
