extends Node
class_name InventoryComponent
@onready var items_container: VBoxContainer = $ItemsContainer
const item_scene:PackedScene = preload("res://item_template.tscn")

@onready var inventory_data: Array[SlotData]
@export var teste_item: Array[SlotData]

func _ready() -> void:
	add_item(teste_item)
	
	update_inventory()

func add_item(slots_data:Array[SlotData]) -> void:
	if slots_data.is_empty():
		return
	
	for slot_data:SlotData in slots_data:
		var item_found: bool = false
		
		for item:SlotData in inventory_data:
			if slot_data.item.name == item.item.name:
				item.amount += slot_data.amount
				item_found = true
				break
		if not item_found:
			var duplicated_slot = slot_data.duplicate()
			inventory_data.append(duplicated_slot)
	update_inventory()


func remove_item(slots_data: Array[SlotData]) -> void:
	for slot_data:SlotData in slots_data:
		var item_name = slot_data.item.name
		for item_data in inventory_data:
			if item_data.item.name == item_name:
				item_data.amount -= slot_data.amount
				update_inventory()

func update_inventory() -> void:
	for c in items_container.get_children():
		c.queue_free()
	
	for item_data in inventory_data:
		var new_item = item_scene.instantiate()
		items_container.add_child(new_item)
		new_item.setup(item_data)


func has_item(item_name: String, amount_need:int) -> bool:
	for item in inventory_data:
		if item.item.name == item_name:
			if item.amount >= amount_need:
				return true
			else:
				return false
	return false
