extends Node2D

@export var items_to_spawn: Array[SlotData]
@onready var item_scene:PackedScene = preload("res://entitites/item/item.tscn")
@onready var marker_top:Marker2D = $MarkerTop
@onready var marker_down:Marker2D = $MarkerDown

func _on_spawn_timer_timeout() -> void:
	var new_item = item_scene.instantiate()
	new_item.global_position.y = randf_range(marker_top.global_position.y, marker_down.global_position.y)
	new_item.global_position.x = marker_down.global_position.x
	add_child(new_item)
	new_item.setup(items_to_spawn.pick_random())
