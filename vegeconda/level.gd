extends Node2D


const FOREST = preload("res://forest.tscn")


func _ready() -> void:
    create_level()


func create_level() -> void:
    var corners : Array
    for i in range(4):
        corners.append(FOREST.instantiate())
    
    corners[0].type = Forest.ForestType.CORNER_TOP_LEFT
    corners[1].type = Forest.ForestType.CORNER_TOP_RIGHT
    corners[2].type = Forest.ForestType.CORNER_BOTTOM_LEFT
    corners[3].type = Forest.ForestType.CORNER_BOTTOM_RIGHT
    
    corners[0].position = Vector2(0, 0) * 16
    corners[1].position = Vector2(19, 0) * 16
    corners[2].position = Vector2(0, 10) * 16
    corners[3].position = Vector2(19, 10) * 16
    
    for corner in corners:
        add_child(corner)
