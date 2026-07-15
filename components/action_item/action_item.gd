extends MarginContainer

@onready var action_name_label: Label = $ActionPanel/CostHBox/ActionNameLabel
@onready var currency_icon: TextureRect = $ActionPanel/CostHBox/CurrencyIcon
@onready var upgrade_button: TextureButton = $ActionPanel/CostHBox/MarginContainer/UpgradeButton

func setup_action(action_data: OrganelleAction, target_function: Callable) -> void:
	action_name_label.text = action_data.action_name
	currency_icon.texture = action_data.icon
	
	var connections: Array = upgrade_button.pressed.get_connections()
	for connection in connections:
		upgrade_button.pressed.disconnect(connection["callable"])
		
	upgrade_button.pressed.connect(target_function)
