extends Node
class_name Organells


@export var texture: Sprite2D


func _ready() -> void:
	var outline_shader_resource: Shader = load("res://entitites/core/outline.gdshader")
	var outline_sahder_material = ShaderMaterial.new()
	outline_sahder_material.shader = outline_shader_resource
	texture.material = outline_sahder_material
	texture.material.set_shader_parameter("outline_color", Color("00000000"))

func select() -> void:
	texture.material.set_shader_parameter("outline_width", 1.0)
	texture.material.set_shader_parameter("outline_color", Color("ffffff"))
	pass

func deselect() -> void:
	texture.material.set_shader_parameter("outline_width", 0.0)
