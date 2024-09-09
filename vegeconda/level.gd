extends Node2D

@export_range(2, 17) var top_door_x: int = 2
@export_range(2, 17) var bottom_door_x: int = 2


const DOOR = preload("res://door.tscn")


const TOP_LEFT_FOREST = Vector2i(0,0)
const TOP_RIGHT_FOREST = Vector2i(3,0)
const BOTTOM_LEFT_FOREST = Vector2i(0,3)
const BOTTOM_RIGHT_FOREST = Vector2i(3,3)

const TOP_FORESTS = [ Vector2i(1,0), Vector2i(2,0), Vector2i(1,1), Vector2i(2,1) ]
const BOTTOM_FORESTS = [ Vector2i(1,2), Vector2i(2,2), Vector2i(1,3), Vector2i(2,3) ]

const LEFT_FORESTS = [ Vector2i(0,1), Vector2i(0,2) ]
const RIGHT_FORESTS = [ Vector2i(3,1), Vector2i(3,2) ]

const TOP_LEFT_DOOR = Vector2i(4,2)
const TOP_RIGHT_DOOR = Vector2i(4,3)
const BOTTOM_LEFT_DOOR = Vector2i(4,0)
const BOTTOM_RIGHT_DOOR = Vector2i(4,1)


const CORNER_FIELDS = [ Vector2i(4,2), Vector2i(4,3) ]
const TOP_FIELDS = [
    Vector2i(0,2), Vector2i(1,2), Vector2i(2,2), Vector2i(0,3), Vector2i(1,3), Vector2i(2,3),
]
const LEFT_FIELDS = [
    Vector2i(3,0), Vector2i(4,0), Vector2i(3,1), Vector2i(4,1), Vector2i(3,2), Vector2i(3,3),
]
const CENTER_FIELDS = [
    Vector2i(0,0), Vector2i(1,0), Vector2i(2,0), Vector2i(0,1), Vector2i(1,1), Vector2i(2,1),
]

var top_door = null
var bottom_door = null


func _ready() -> void:
    _create_level()


func _create_level() -> void:
    _create_forest()
    _create_field()
    _create_top_door()
    _create_bottom_door()


func _create_forest() -> void:
    $TileMapLayer.set_cell(Vector2i(0,0), 0, TOP_LEFT_FOREST)
    $TileMapLayer.set_cell(Vector2i(19,0), 0, TOP_RIGHT_FOREST)
    $TileMapLayer.set_cell(Vector2i(0,10), 0, BOTTOM_LEFT_FOREST)
    $TileMapLayer.set_cell(Vector2i(19,10), 0, BOTTOM_RIGHT_FOREST)
    
    for i in range(1, 19):
        $TileMapLayer.set_cell(Vector2i(i,0), 0, TOP_FORESTS[randi() % TOP_FORESTS.size()])
        $TileMapLayer.set_cell(Vector2i(i,10), 0, BOTTOM_FORESTS[randi() % BOTTOM_FORESTS.size()])
    
    for i in range(1, 10):
        $TileMapLayer.set_cell(Vector2i(0,i), 0, LEFT_FORESTS[randi() % LEFT_FORESTS.size()])
        $TileMapLayer.set_cell(Vector2i(19,i), 0, RIGHT_FORESTS[randi() % RIGHT_FORESTS.size()])


func _create_field() -> void:
    $TileMapLayer.set_cell(Vector2i(1,1), 1, CORNER_FIELDS[randi() % CORNER_FIELDS.size()])
    
    for i in range(2, 19):
        $TileMapLayer.set_cell(Vector2i(i,1), 1, TOP_FIELDS[randi() % TOP_FIELDS.size()])
        
    for i in range(2, 10):
        $TileMapLayer.set_cell(Vector2i(1,i), 1, LEFT_FIELDS[randi() % LEFT_FIELDS.size()])
        
    for i in range(2, 19):
        for j in range(2, 10):
            $TileMapLayer.set_cell(Vector2i(i,j), 1, CENTER_FIELDS[randi() % CENTER_FIELDS.size()])

func _create_top_door():
    const y = 0
    $TileMapLayer.set_cell(Vector2i(top_door_x-1,y), 0, TOP_LEFT_DOOR)
    $TileMapLayer.set_cell(Vector2i(top_door_x,y), 1, LEFT_FIELDS[randi() % LEFT_FIELDS.size()])
    $TileMapLayer.set_cell(Vector2i(top_door_x,y+1), 1, CENTER_FIELDS[randi() % LEFT_FIELDS.size()])
    $TileMapLayer.set_cell(Vector2i(top_door_x+1,y), 0, TOP_RIGHT_DOOR)
    
    top_door = DOOR.instantiate()
    top_door.type = Door.DoorType.TOP_DOOR
    top_door.state = Door.DoorState.CLOSED
    top_door.position = Vector2i(top_door_x,y)*16
    add_child(top_door)
    
    $CollisionBoxTopLeft.shape.size.x = (top_door_x - 1) * 16
    $CollisionBoxTopLeft.position.x += $CollisionBoxTopLeft.shape.size.x/2 - 8
    
    $CollisionBoxTopRight.shape.size.x = (20 - top_door_x - 2) * 16
    $CollisionBoxTopRight.position.x -= $CollisionBoxTopRight.shape.size.x/2 - 8


func _create_bottom_door():
    const y = 10
    $TileMapLayer.set_cell(Vector2i(bottom_door_x-1,y), 0, BOTTOM_LEFT_DOOR)
    $TileMapLayer.set_cell(Vector2i(bottom_door_x,y), 1, LEFT_FIELDS[randi() % LEFT_FIELDS.size()])
    $TileMapLayer.set_cell(Vector2i(bottom_door_x+1,y), 0, BOTTOM_RIGHT_DOOR)
    
    bottom_door = DOOR.instantiate()
    bottom_door.type = Door.DoorType.BOTTOM_DOOR
    bottom_door.state = Door.DoorState.OPENED
    bottom_door.position = Vector2i(bottom_door_x,y)*16
    add_child(bottom_door)
    
    
    $CollisionBoxBottomLeft.shape.size.x = (bottom_door_x - 1) * 16
    $CollisionBoxBottomLeft.position.x += $CollisionBoxBottomLeft.shape.size.x/2 - 8
    
    $CollisionBoxBottomRight.shape.size.x = (20 - bottom_door_x - 2) * 16
    $CollisionBoxBottomRight.position.x -= $CollisionBoxBottomRight.shape.size.x/2 - 8
