extends PanelContainer

@onready var action_description: Label = $ContentMargin/ContentVBox/DescriptionLabel
@onready var content_v_box: VBoxContainer = $ContentMargin/ContentVBox
@onready var description_label: Label = $ContentMargin/ContentVBox/DescriptionLabel

const cost_h_box_scene:PackedScene = preload("res://components/cost_h_box.tscn")

func setup(action_data: OrganelleAction) -> void:
	for slot_data:SlotData in action_data.cost:
		var cost_h_box = cost_h_box_scene.instantiate()
		content_v_box.add_child(cost_h_box)
		cost_h_box.setup(slot_data.amount, slot_data.item.texture)
		description_label.text = action_data.description
		
