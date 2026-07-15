extends Control

@onready var action_container = %ActionContainer 
const action_btn = preload("res://components/action_item/action_item.tscn")

func update_hud(current_organelle: Node) -> void:
	for child in action_container.get_children():
		child.queue_free()

	if "actions" in current_organelle and typeof(current_organelle.actions) == TYPE_ARRAY:
		var organelle_actions: Array = current_organelle.actions
		
		for actions_resource in organelle_actions:
			if actions_resource == null:
				continue
			
			var new_action = action_btn.instantiate()
			action_container.add_child(new_action)
			
			var target_function = Callable(current_organelle, actions_resource.method_to_call)
			new_action.setup_action(actions_resource, target_function)
