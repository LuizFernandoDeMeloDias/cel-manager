extends PanelContainer

@onready var action_description: Label = $ContentMargin/ContentVBox/DescriptionLabel
@onready var content_v_box: VBoxContainer = $ContentMargin/ContentVBox
@onready var description_label: Label = $ContentMargin/ContentVBox/DescriptionLabel

const COST_H_BOX_SCENE:PackedScene = preload("res://components/cost_h_box.tscn")

func setup(action_data: OrganelleAction, current_level) -> void:
	description_label.text = action_data.description
	
	var current_costs: Array[SlotData] = []
	
	if action_data is StandardAction:
		current_costs = action_data.costs
	elif action_data is UpgradeAction:
		if current_level < action_data.upgrade_tiers.size():
			current_costs = action_data.upgrade_tiers[current_level].costs

	for slot_data: SlotData in current_costs:
		var cost_h_box = COST_H_BOX_SCENE.instantiate()
		content_v_box.add_child(cost_h_box)
		
		cost_h_box.setup(slot_data.amount, slot_data.item.texture)
