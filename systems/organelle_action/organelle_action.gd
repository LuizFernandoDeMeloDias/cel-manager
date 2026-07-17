extends Resource
class_name OrganelleAction

@export_category("UI Details")
@export var action_name: String = "Action Name"
@export var description: String
@export var icon: Texture2D

@export_category("Mechanics")
@export var method_to_call: String = "function_name"
@export var task_time: int
@export var is_consumable:bool = false

@export_category("Economy")
@export var cost: Array[SlotData]
@export var result: Array[SlotData]
