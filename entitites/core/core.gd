extends Organells

@onready var atp_progress_timer: Timer = $ProgressTimer
@onready var atp_decrease_hide_timer: Timer = $ATPDecreaseHideTimer

@onready var  atp_progress_bar: ProgressBar = $ATPDecreaseProgress
@onready var animation: AnimationPlayer = $Animation
@onready var ATP_amount: Panel = $ATPAmountBackground

@onready var inventory_ref:InventoryComponent = get_tree().get_first_node_in_group("inventory_component")

var core_energy: int = 60
var shaking_speed: float = 1.0

func select() -> void:
	super()
	atp_progress_bar.show()
func deselect() -> void:
	super()
	atp_decrease_hide_timer.start()

func update_cell():
	animation.speed_scale = remap(core_energy, 60, 0, 0.1, 1)
	atp_progress_bar.value = core_energy / 60.0 * 100

func _on_atp_decrease_timer_timeout() -> void:
	core_energy -= 1
	animation.speed_scale = remap(core_energy, 60, 0, 0.1, 1)
	atp_progress_bar.value = core_energy / 60.0 * 100
	
	if atp_progress_bar.value == 0:
		print("você perdeu!") # Fazer a Tela de GameOver

func _on_restore_atp(action_resource: OrganelleAction) -> void:
	var costs = action_resource.cost
	var results = action_resource.result
	
	for cost in costs:
		if !inventory_ref.has_item(cost.item.name, cost.amount):
			return
	
	if core_energy < 60:
		core_energy = 60
		update_cell()
		inventory_ref.remove_item(costs)
		inventory_ref.add_item(results)
	else:
		print("Quantidade Cheia")

func _on_mouse_detector_mouse_entered() -> void:
	if !is_selected:
		atp_decrease_hide_timer.stop()
		atp_progress_bar.show()

func _on_mouse_detector_mouse_exited() -> void:
	if !is_selected:
		atp_decrease_hide_timer.start()
func _on_atp_decrease_hide_timer_timeout() -> void:
	atp_progress_bar.hide()
