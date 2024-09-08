extends StaticBody2D


enum PickupType {CHERRY, FLY_AGARIC, GREEN_APPLE, RED_APPLE}
@export var pickup_type: PickupType

enum PickupState {PREPARING, SHOWING_UP, IDLING, HIGHLIGHTING}
@export var pickup_state: PickupState = PickupState.PREPARING


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



func _init(type : PickupType = PickupType.RED_APPLE) -> void:
    pickup_type = type


func _ready() -> void:
    play_animation()
    
    
func highlight() -> void:
    pickup_state = PickupState.HIGHLIGHTING
    play_animation()


func play_animation() -> void:
    var animation : String
    if pickup_state == PickupState.PREPARING:
        animation = ANIMATIONS_BY_STATE[pickup_state]
    else:
        animation = "%s_%s" % [
            ANIMATIONS_BY_TYPE[pickup_type], 
            ANIMATIONS_BY_STATE[pickup_state]
        ]
    $AnimatedSprite2D.play(animation)


func _on_animated_sprite_2d_animation_finished() -> void:
    match pickup_state:
        PickupState.PREPARING:
            pickup_state = PickupState.SHOWING_UP
            play_animation()
        PickupState.SHOWING_UP:
            pickup_state = PickupState.IDLING
            play_animation()
        PickupState.HIGHLIGHTING:
            pickup_state = PickupState.IDLING
            play_animation()
