extends Organells

@onready var animation:AnimationPlayer = $Animation
@onready var task_timer: Timer = $TaskTimer 
@onready var inventory_ref: InventoryComponent = get_tree().get_first_node_in_group("inventory_component")

var is_busy: bool = false

func _generate_atp(actions_resource: OrganelleAction) -> void:
	if is_busy == true:
		return
		
		
	for cost_item in actions_resource.costs:
		if not inventory_ref.has_item(cost_item.item.name, cost_item.amount):
			return
	
	var current_level: int = 0
	if has_method("get_upgrade_level"):
		current_level = get_upgrade_level("Melhorar Produção")
		
	var level_stats: Dictionary = EconomyData.mitochondria_levels.get(current_level, EconomyData.mitochondria_levels[0])
	
	var time_modifier: float = level_stats.get("production_time", 1.0)
	var atp_bonus: int = level_stats.get("atp_production_increase", 0)
	
	animation.play("generating_atp")
	
	var final_time: float = actions_resource.task_time * time_modifier
	configure_timer(final_time, true)
	
	is_busy = true
	task_timer.start()
	
	await task_timer.timeout
	inventory_ref.remove_item(actions_resource.costs)
	
	var dynamic_results: Array[SlotData] = []
	
	for original_slot in actions_resource.results:
		var modified_slot: SlotData = original_slot.duplicate() 
		modified_slot.amount += atp_bonus 
		dynamic_results.append(modified_slot)
	inventory_ref.add_item(dynamic_results)
	
	animation.play("idle")
	is_busy = false

func _upgrade(new_action_resource: UpgradeAction) -> void:
	var current_lvl: int = get_upgrade_level(new_action_resource.action_name)
	var costs = new_action_resource.upgrade_tiers[current_lvl].costs
	for cost in costs:
		if !inventory_ref.has_item(cost.item.name, cost.amount):
			return
	
	if current_lvl >= new_action_resource.upgrade_tiers.size():
		print("Max level reached")
		return
	upgrade_levels[new_action_resource.action_name] = current_lvl + 1
	print(upgrade_levels[new_action_resource.action_name])
	inventory_ref.remove_item(new_action_resource.upgrade_tiers[current_lvl].costs)
	hud.update_hud(self)

func configure_timer(wait_time: int, one_shot: bool) -> void:
	task_timer.wait_time = wait_time
	task_timer.one_shot = one_shot
