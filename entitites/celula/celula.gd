extends Node2D

var organelles: Array = []
var current_index: int = 1
@onready var hud = get_tree().get_first_node_in_group("hud")

func _ready() -> void:
	organelles = $Organelles.get_children()

func update_navigation() -> void:
	for i in range(organelles.size()):
		var organelle = organelles[i]
		if i == current_index:
			organelle.select()
			hud.update_hud(organelle)
		else:
			organelle.deselect()

func _unhandled_input(event: InputEvent) -> void:
	if organelles.is_empty():
		return
	
	if event.is_action_pressed("ui_right"):
		current_index += 1
		if current_index >= organelles.size():
			current_index = 0
		update_navigation()
	elif event.is_action_pressed("ui_left"):
		current_index -= 1
		if current_index < 0:
			current_index = organelles.size() - 1
		update_navigation()
