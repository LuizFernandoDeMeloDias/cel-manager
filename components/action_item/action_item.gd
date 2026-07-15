extends MarginContainer

@onready var action_name_label: Label = $ActionPanel/CostHBox/TitleMargin/ActionNameLabel
@onready var currency_icon: TextureRect = $ActionPanel/CostHBox/CurrencyIcon
@onready var upgrade_button: TextureButton = $ActionPanel/CostHBox/ButtonMargin/UpgradeButton
@onready var details_panel: PanelContainer = $ActionPanel/CostHBox/ButtonMargin/UpgradeButton/DetailsPanel


func setup_action(action_data: OrganelleAction, target_function: Callable) -> void:
	action_name_label.text = action_data.action_name
	currency_icon.texture = action_data.icon
	
	details_panel.setup(action_data)
	
	var connections: Array = upgrade_button.pressed.get_connections()
	for connection in connections:
		upgrade_button.pressed.disconnect(connection["callable"])
	upgrade_button.pressed.connect(target_function)


func _on_upgrade_button_mouse_entered() -> void:
	details_panel.show()

func _on_upgrade_button_mouse_exited() -> void:
	details_panel.hide()
