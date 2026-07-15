extends Panel

@onready var item_texture:TextureRect = $ItemRow/Amount/ItemTexture
@onready var amount_label:Label = $ItemRow/Amount


func setup(slot_data:SlotData) -> void:
	amount_label.text = str(slot_data.amount)
	item_texture.texture = slot_data.item.texture
