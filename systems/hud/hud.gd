extends Control

@onready var action_container = %ActionContainer 
@onready var inventory_ref: InventoryComponent = get_tree().get_first_node_in_group("inventory_component")
const action_btn = preload("res://components/action_item/action_item.tscn")

@export var itens_teste: Array[SlotData]


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_home"):
		inventory_ref.add_item(itens_teste)


func update_hud(current_organelle: Node) -> void:
	for child in action_container.get_children():
		child.queue_free()

	if "actions" in current_organelle and typeof(current_organelle.actions) == TYPE_ARRAY:
		var organelle_actions: Array = current_organelle.actions
		
		for actions_resource:OrganelleAction in organelle_actions:
			if actions_resource == null:
				continue
			
			var new_action = action_btn.instantiate()
			action_container.add_child(new_action)
			var target_function = Callable(current_organelle, actions_resource.method_to_call).bind(actions_resource)
			new_action.setup_action(actions_resource, target_function)
