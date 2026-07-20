extends Organells

@onready var animation:AnimationPlayer = $Animation
@onready var task_timer: Timer = $TaskTimer 
@onready var inventory_ref: InventoryComponent = get_tree().get_first_node_in_group("inventory_component")

var is_busy: bool = false
var level:int  = 0

func _generate_atp(actions_resource: OrganelleAction) -> void:
	if is_busy == true:
		return
		
	for cost in actions_resource.cost:
		if !inventory_ref.has_item(cost.item.name, cost.amount):
			return
	
	animation.play("generating_atp")
	configure_timer(actions_resource.task_time, true)
	is_busy = true
	task_timer.start()
	await task_timer.timeout
	inventory_ref.remove_item(actions_resource.cost)
	inventory_ref.add_item(actions_resource.result)
	animation.play("idle")
	is_busy = false

func _upgrade(new_action_resource: OrganelleAction) -> void:
	for action:OrganelleAction in actions:
		if action.action_name == new_action_resource.action_name:
			actions.erase(action)

func configure_timer(wait_time: int, one_shot: bool) -> void:
	task_timer.wait_time = wait_time
	task_timer.one_shot = one_shot
