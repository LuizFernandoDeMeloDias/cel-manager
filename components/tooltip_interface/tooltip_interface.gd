extends PanelContainer

@onready var item_texture: TextureRect = %ItemTexture
@onready var action_label:Label = %Action

func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()

func setup(action:String, texture:Texture ) -> void:
	print(texture)
	item_texture.texture = texture
	action_label.text = action
