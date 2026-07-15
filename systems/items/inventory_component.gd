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
	if inventory_data.is_empty():
		for slot_data in slots_data:
			inventory_data.append(slot_data)
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
