extends Node2D


func _ready() -> void:
    create_level()


func create_level() -> void:
    create_forest()
    create_field()


func create_forest() -> void:
    $TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(0,0))
    $TileMapLayer.set_cell(Vector2i(19,0), 0, Vector2i(3,0))
    $TileMapLayer.set_cell(Vector2i(0,10), 0, Vector2i(0,3))
    $TileMapLayer.set_cell(Vector2i(19,10), 0, Vector2i(3,3))
    
    const TOP_TILES = [ Vector2i(1,0), Vector2i(2,0), Vector2i(1,1), Vector2i(2,1) ]
    const BOTTOM_TILES = [ Vector2i(1,2), Vector2i(2,2), Vector2i(1,3), Vector2i(2,3) ]
    for i in range(1, 19):
        $TileMapLayer.set_cell(Vector2i(i,0), 0, TOP_TILES[randi() % TOP_TILES.size()])
        $TileMapLayer.set_cell(Vector2i(i,10), 0, BOTTOM_TILES[randi() % BOTTOM_TILES.size()])
    
    const LEFT_TILES = [ Vector2i(0,1), Vector2i(0,2) ]
    const RIGHT_TILES = [ Vector2i(3,1), Vector2i(3,2) ]
    for i in range(1, 10):
        $TileMapLayer.set_cell(Vector2i(0,i), 0, LEFT_TILES[randi() % LEFT_TILES.size()])
        $TileMapLayer.set_cell(Vector2i(19,i), 0, RIGHT_TILES[randi() % RIGHT_TILES.size()])


func create_field() -> void:
    const CORNER_TILES = [ Vector2i(4,2), Vector2i(4,3) ]
    $TileMapLayer.set_cell(Vector2i(1,1), 1, CORNER_TILES[randi() % CORNER_TILES.size()])
    const TOP_TILES = [
        Vector2i(0,2), Vector2i(1,2), Vector2i(2,2),
        Vector2i(0,3), Vector2i(1,3), Vector2i(2,3),
    ]
    for i in range(2, 19):
        $TileMapLayer.set_cell(Vector2i(i,1), 1, TOP_TILES[randi() % TOP_TILES.size()])
    const LEFT_TILES = [
        Vector2i(3,0), Vector2i(4,0), Vector2i(3,1),
        Vector2i(4,1), Vector2i(3,2), Vector2i(3,3),
    ]
    for i in range(2, 10):
        $TileMapLayer.set_cell(Vector2i(1,i), 1, LEFT_TILES[randi() % LEFT_TILES.size()])
    const CENTER_TILES = [
        Vector2i(0,0), Vector2i(1,0), Vector2i(2,0),
        Vector2i(0,1), Vector2i(1,1), Vector2i(2,1),
    ]
    for i in range(2, 19):
        for j in range(2, 10):
            $TileMapLayer.set_cell(Vector2i(i,j), 1, CENTER_TILES[randi() % CENTER_TILES.size()])
