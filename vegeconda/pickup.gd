class_name Pickup

extends StaticBody2D


enum PickupType {CHERRY, FLY_AGARIC, GREEN_APPLE, RED_APPLE}
@export var type: PickupType

enum PickupState {PREPARING, SHOWING_UP, IDLING, HIGHLIGHTING}
@export var state: PickupState = PickupState.PREPARING


var ANIMATIONS_BY_TYPE : Dictionary = {
    PickupType.CHERRY: "cherry",
    PickupType.FLY_AGARIC: "fly_agaric",
    PickupType.GREEN_APPLE: "green_apple",
    PickupType.RED_APPLE: "red_apple",
}

var ANIMATIONS_BY_STATE : Dictionary = {
    PickupState.PREPARING: "preparing",
    PickupState.SHOWING_UP: "showing_up",
    PickupState.IDLING: "idling",
    PickupState.HIGHLIGHTING: "highlighting",
}


func _ready() -> void:
    _play_animation()


func _play_animation() -> void:
    var animation : String
    if state == PickupState.PREPARING:
        animation = ANIMATIONS_BY_STATE[state]
    else:
        animation = "%s_%s" % [
            ANIMATIONS_BY_TYPE[type], 
            ANIMATIONS_BY_STATE[state]
        ]
    $AnimatedSprite2D.play(animation)


func _on_animated_sprite_2d_animation_finished() -> void:
    match state:
        PickupState.PREPARING:
            state = PickupState.SHOWING_UP
            _play_animation()
        PickupState.SHOWING_UP:
            state = PickupState.IDLING
            _play_animation()
        PickupState.HIGHLIGHTING:
            state = PickupState.IDLING
            _play_animation()


func highlight() -> void:
    state = PickupState.HIGHLIGHTING
    _play_animation()
