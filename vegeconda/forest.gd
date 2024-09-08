class_name Forest

extends StaticBody2D


enum ForestType {
    TOP, BOTTOM, LEFT, RIGHT,
    CORNER_TOP_LEFT, CORNER_TOP_RIGHT,
    CORNER_BOTTOM_LEFT, CORNER_BOTTOM_RIGHT,
    FRAME_TOP_LEFT, FRAME_TOP_RIGHT,
    FRAME_BOTTOM_LEFT, FRAME_BOTTOM_RIGHT,
}
@export var type: ForestType


var POSITIONS_BY_TYPE : Dictionary = {
    ForestType.TOP: [
            Vector2(16, 0),
            Vector2(32, 0),
            Vector2(16, 16),
            Vector2(32, 16),
        ],
    ForestType.BOTTOM: [
            Vector2(16, 32),
            Vector2(32, 32),
            Vector2(16, 48),
            Vector2(32, 48),
        ],
    ForestType.LEFT: [
            Vector2(0, 16),
            Vector2(0, 32),
        ],
    ForestType.RIGHT: [
            Vector2(48, 16),
            Vector2(48, 32),
        ],
    ForestType.CORNER_TOP_LEFT: [
            Vector2(0, 0),
        ],
    ForestType.CORNER_TOP_RIGHT: [
            Vector2(48, 0),
        ],
    ForestType.CORNER_BOTTOM_LEFT: [
            Vector2(0, 48),
        ],
    ForestType.CORNER_BOTTOM_RIGHT: [
            Vector2(48, 48),
        ],
    ForestType.FRAME_TOP_LEFT: [
            Vector2(64, 32),
        ],
    ForestType.FRAME_TOP_RIGHT: [
            Vector2(64, 48),
        ],
    ForestType.FRAME_BOTTOM_LEFT: [
            Vector2(64, 0),
        ],
    ForestType.FRAME_BOTTOM_RIGHT: [
            Vector2(64, 16),
        ],
}
    

func _ready() -> void:
    update_atlas_position()


func update_atlas_position() -> void:
    var positions = POSITIONS_BY_TYPE[type]
    $Sprite2D.texture.region.position = positions[randi() % positions.size()]
