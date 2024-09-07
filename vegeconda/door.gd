extends StaticBody2D


enum DoorType {BOTTOM_DOOR, TOP_DOOR}
@export var door_type: DoorType

enum DoorState {OPENED, CLOSED, OPENING, CLOSING}
@export var door_state: DoorState


var ANIMATIONS_BY_TYPE : Dictionary = {
    DoorType.BOTTOM_DOOR: "bottom_door",
    DoorType.TOP_DOOR: "top_door",
}

var ANIMATIONS_BY_STATE : Dictionary = {
    DoorState.OPENED: "opened",
    DoorState.CLOSED: "closed",
    DoorState.OPENING: "opening",
    DoorState.CLOSING: "closing",
}


signal opened()
signal closed()


func _init(type: DoorType = DoorType.BOTTOM_DOOR, state: DoorState = DoorState.OPENED) -> void:
    door_type = type
    door_state = state


func _ready() -> void:
    play_animation()


func play_animation() -> void:
    var animation = "%s_%s" % [
        ANIMATIONS_BY_TYPE[door_type], 
        ANIMATIONS_BY_STATE[door_state]
    ]
    $AnimatedSprite2D.play(animation)


func open() -> void:
    if door_state != DoorState.CLOSED:
        print("Door in state '%s' can't be opened" % DoorState.find_key(door_state))
        return

    door_state = DoorState.OPENING
    play_animation()
    
    
    
func close():
    if door_state != DoorState.OPENED:
        print("Door in state '%s' can't be closed" % DoorState.find_key(door_state))
        return

    door_state = DoorState.CLOSING
    play_animation()


func _on_animated_sprite_2d_animation_finished() -> void:
    if door_state == DoorState.CLOSING:
        door_state = DoorState.CLOSED
        $CollisionShape2D.disabled = false
        play_animation()
    elif door_state == DoorState.OPENING:
        door_state = DoorState.OPENED
        $CollisionShape2D.disabled = true
        play_animation()
    elif door_state == DoorState.CLOSED:
        closed.emit()
    elif door_state == DoorState.OPENED:
        opened.emit()
