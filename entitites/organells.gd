extends Node
class_name Organells


@export var texture: Sprite2D
@export var actions: Array[OrganelleAction]

@onready var hud = get_tree().get_first_node_in_group("hud")

var is_selected: bool
var upgrade_levels: Dictionary = {}



func get_upgrade_level(action_name: String) -> int:
	if upgrade_levels.has(action_name):
		return upgrade_levels[action_name]
	return 0

func _ready() -> void:
	var outline_shader_resource: Shader = load("res://entitites/core/outline.gdshader")
	var outline_sahder_material = ShaderMaterial.new()
	outline_sahder_material.shader = outline_shader_resource
	texture.material = outline_sahder_material
	texture.material.set_shader_parameter("outline_color", Color("ffffff00"))

func select() -> void:
	texture.material.set_shader_parameter("outline_width", 1.0)
	texture.material.set_shader_parameter("outline_color", Color("ffffff"))
	is_selected = true

func deselect() -> void:
	texture.material.set_shader_parameter("outline_width", 0.0)
	is_selected = false
