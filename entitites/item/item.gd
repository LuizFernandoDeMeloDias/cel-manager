extends Node2D

@onready var texture: Sprite2D = $Texture

@onready var inventory_ref: InventoryComponent = get_tree().get_first_node_in_group("inventory_component")

@onready var slot_data: SlotData

var focused: bool = false

func _process(delta: float) -> void:
	position.x -= 80 * delta


func setup(new_slot_data: SlotData) -> void:
	slot_data = new_slot_data
	var item_data = slot_data.item
	texture.texture = item_data.texture

func _on_area_mouse_entered() -> void:
	focused = true
func _on_area_mouse_exited() -> void:
	focused = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not focused:
			return
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			inventory_ref.add_item([slot_data])
			self.queue_free()
