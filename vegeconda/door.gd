class_name Door

extends StaticBody2D


enum DoorType {BOTTOM_DOOR, TOP_DOOR}
@export var type: DoorType

enum DoorState {OPENED, CLOSED, OPENING, CLOSING}
@export var state: DoorState


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


func _ready() -> void:
    play_animation()


func play_animation() -> void:
    var animation : String = "%s_%s" % [
        ANIMATIONS_BY_TYPE[type], 
        ANIMATIONS_BY_STATE[state]
    ]
    $AnimatedSprite2D.play(animation)


func open() -> void:
    if state != DoorState.CLOSED:
        print("Door in state '%s' can't be opened" % DoorState.find_key(state))
        return

    state = DoorState.OPENING
    play_animation()
    
    
    
func close():
    if state != DoorState.OPENED:
        print("Door in state '%s' can't be closed" % DoorState.find_key(state))
        return

    state = DoorState.CLOSING
    play_animation()


func _on_animated_sprite_2d_animation_finished() -> void:
    match state:
        DoorState.CLOSING:
            state = DoorState.CLOSED
            $CollisionShape2D.disabled = false
            play_animation()
        DoorState.OPENING:
            state = DoorState.OPENED
            $CollisionShape2D.disabled = true
            play_animation()
        DoorState.CLOSED:
            closed.emit()
        DoorState.OPENED:
            opened.emit()
