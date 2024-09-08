extends StaticBody2D


enum FieldType {
    MIDDLE, CORNER, TOP, LEFT,
}
@export var field_type: FieldType


var POSITIONS_BY_TYPE : Dictionary = {
    FieldType.MIDDLE: [
            Vector2(0, 0),
            Vector2(16, 0),
            Vector2(32, 0),
            Vector2(0, 16),
            Vector2(16, 16),
            Vector2(32, 16),
        ],
    FieldType.CORNER: [
            Vector2(64, 32),
            Vector2(64, 48),
        ],
    FieldType.TOP: [
            Vector2(0, 32),
            Vector2(16, 32),
            Vector2(32, 32),
            Vector2(0, 48),
            Vector2(16, 48),
            Vector2(32, 48),
        ],
    FieldType.LEFT: [
            Vector2(48, 0),
            Vector2(48, 16),
            Vector2(48, 32),
            Vector2(48, 48),
            Vector2(64, 0),
            Vector2(64, 16),
        ],
}


func _init(type : FieldType = FieldType.MIDDLE) -> void:
    field_type = type
    

func _ready() -> void:
    update_atlas_position()


func update_atlas_position() -> void:
    var positions = POSITIONS_BY_TYPE[field_type]
    $Sprite2D.texture.region.position = positions[randi() % positions.size()]
