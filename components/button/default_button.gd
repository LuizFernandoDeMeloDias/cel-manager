extends TextureButton

const TOOL_TIP_BUTTON_INTERFACE_SCENE: PackedScene = preload("res://components/tooltip_interface/tooltip_interface.tscn")

@export var tool_tip_item_texture: Texture
@export var tool_tip_action: String = ""

var tool_tip_interface_ref: PanelContainer

func create_tool_tip() -> void:
	var tool_tip_interface = TOOL_TIP_BUTTON_INTERFACE_SCENE.instantiate()
	add_child(tool_tip_interface)
	tool_tip_interface_ref = tool_tip_interface
	tool_tip_interface.setup(tool_tip_action, tool_tip_item_texture)

func delete_tool_tip() -> void:
	tool_tip_interface_ref.queue_free()
	tool_tip_interface_ref = null

func _on_mouse_entered() -> void:
	create_tool_tip()

func _on_mouse_exited() -> void:
	delete_tool_tip()
