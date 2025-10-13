class_name SnakeSegment

extends StaticBody2D


@export var is_eating: bool = false

enum Direction {EAST, NORTH, SOUTH, WEST}
@export var direction: Direction = Direction.EAST

enum Wave {LEFT, RIGHT}
@export var wave: Wave = Wave.LEFT

enum Turn {LEFT, RIGHT, STRAIGHT}
@export var turn: Turn = Turn.STRAIGHT

enum State {
    NA_FINISHED, NA_DEAD,
    DEAD_LEFT, DEAD_RIGHT,
    EAT_PHASE_1_LEFT, EAT_PHASE_1_RIGHT,
    EAT_PHASE_2,
    EAT_TAIL_PHASE_1, EAT_TAIL_PHASE_2, EAT_TAIL_PHASE_3,
    EAT_WAVES,
    HEAD_IN_PHASE_1_LEFT, HEAD_IN_PHASE_1_MIDDLE, HEAD_IN_PHASE_1_RIGHT,
    HEAD_IN_PHASE_2_LEFT, HEAD_IN_PHASE_2_RIGHT,
    HEAD_OUT_LEFT, HEAD_OUT_RIGHT,
    TAIL_LEFT_PHASE_1, TAIL_LEFT_PHASE_2,
    TAIL_RIGHT_PHASE_1, TAIL_RIGHT_PHASE_2,
    TURN_LEFT_IN_PHASE_1, TURN_LEFT_IN_PHASE_2,
    TURN_LEFT_OUT_PHASE_1, TURN_LEFT_OUT_PHASE_2,
    TURN_LEFT_TAIL_PHASE_1, TURN_LEFT_TAIL_PHASE_2,
    TURN_LEFT_WAVES,
    TURN_RIGHT_IN_PHASE_1, TURN_RIGHT_IN_PHASE_2,
    TURN_RIGHT_OUT_PHASE_1, TURN_RIGHT_OUT_PHASE_2,
    TURN_RIGHT_TAIL_PHASE_1, TURN_RIGHT_TAIL_PHASE_2,
    TURN_RIGHT_WAVES,
    WAVES_LEFT, WAVES_RIGHT
}
@export var state: State = State.NA_FINISHED


const ANIMATIONS_BY_DIRECTION := {
    Direction.EAST: "east",
    Direction.NORTH: "north",
    Direction.SOUTH: "south",
    Direction.WEST: "west",
}

const ANIMATIONS_BY_STATE := {
    State.DEAD_LEFT: "dead_left",
    State.DEAD_RIGHT: "dead_right",
    State.EAT_PHASE_1_LEFT: "eat_phase_1_left",
    State.EAT_PHASE_1_RIGHT: "eat_phase_1_right",
    State.EAT_PHASE_2: "eat_phase_2",
    State.EAT_TAIL_PHASE_1: "eat_tail_phase_1",
    State.EAT_TAIL_PHASE_2: "eat_tail_phase_2",
    State.EAT_TAIL_PHASE_3: "eat_tail_phase_3",
    State.EAT_WAVES: "eat_waves",
    State.HEAD_IN_PHASE_1_LEFT: "head_in_phase_1_left",
    State.HEAD_IN_PHASE_1_MIDDLE: "head_in_phase_1_middle",
    State.HEAD_IN_PHASE_1_RIGHT: "head_in_phase_1_right",
    State.HEAD_IN_PHASE_2_LEFT: "head_in_phase_2_left",
    State.HEAD_IN_PHASE_2_RIGHT: "head_in_phase_2_right",
    State.HEAD_OUT_LEFT: "head_out_left",
    State.HEAD_OUT_RIGHT: "head_out_right",
    State.TAIL_LEFT_PHASE_1: "tail_left_phase_1",
    State.TAIL_LEFT_PHASE_2: "tail_left_phase_2",
    State.TAIL_RIGHT_PHASE_1: "tail_right_phase_1",
    State.TAIL_RIGHT_PHASE_2: "tail_right_phase_2",
    State.TURN_LEFT_IN_PHASE_1: "turn_left_in_phase_1",
    State.TURN_LEFT_IN_PHASE_2: "turn_left_in_phase_2",
    State.TURN_LEFT_OUT_PHASE_1: "turn_left_out_phase_1",
    State.TURN_LEFT_OUT_PHASE_2: "turn_left_out_phase_2",
    State.TURN_LEFT_TAIL_PHASE_1: "turn_left_tail_phase_1",
    State.TURN_LEFT_TAIL_PHASE_2: "turn_left_tail_phase_2",
    State.TURN_LEFT_WAVES: "turn_left_waves",
    State.TURN_RIGHT_IN_PHASE_1: "turn_right_in_phase_1",
    State.TURN_RIGHT_IN_PHASE_2: "turn_right_in_phase_2",
    State.TURN_RIGHT_OUT_PHASE_1: "turn_right_out_phase_1",
    State.TURN_RIGHT_OUT_PHASE_2: "turn_right_out_phase_2",
    State.TURN_RIGHT_TAIL_PHASE_1: "turn_right_tail_phase_1",
    State.TURN_RIGHT_TAIL_PHASE_2: "turn_right_tail_phase_2",
    State.TURN_RIGHT_WAVES: "turn_right_waves",
    State.WAVES_LEFT: "waves_left",
    State.WAVES_RIGHT: "waves_right",
}

func start_tail():
    match turn:
        Turn.STRAIGHT:
            match wave:
                Wave.LEFT:
                    pass
                Wave.RIGHT:
                    pass
            pass
        Turn.LEFT:
            state = State.TURN_LEFT_TAIL_PHASE_1
        Turn.RIGHT:
            state = State.TURN_RIGHT_TAIL_PHASE_1
            pass
    

func _reset() -> void:
    if state != State.NA_FINISHED: return
    
    match wave:
        Wave.LEFT:
            state = State.EAT_PHASE_1_LEFT if is_eating else State.HEAD_IN_PHASE_1_LEFT
        Wave.RIGHT:
            state =State.EAT_PHASE_1_RIGHT if is_eating else  State.HEAD_IN_PHASE_1_RIGHT


func _ready() -> void:
    _reset()
    
    _play_animation()
    
    
func _play_animation() -> void:
    if not ANIMATIONS_BY_STATE.has(state):
        #TODO Deletion of the segment
        _reset()
        _play_animation()
        return
    
    var animation : String
    animation = "%s_%s" % [
        ANIMATIONS_BY_DIRECTION[direction], 
        ANIMATIONS_BY_STATE[state]
    ]
    $AnimatedSprite2D.play(animation)


func _on_animated_sprite_2d_animation_finished() -> void:
    print('Old state', State.keys()[state])
    state = _get_new_state()
    print('New state', State.keys()[state])
    _play_animation()

func _get_new_state() -> State:
    match state:
        State.DEAD_LEFT, State.DEAD_RIGHT:
            return State.NA_DEAD
        State.EAT_PHASE_1_LEFT, State.EAT_PHASE_1_RIGHT:
            return State.EAT_PHASE_2
            
        State.EAT_TAIL_PHASE_1:
            return State.EAT_TAIL_PHASE_2
        State.EAT_TAIL_PHASE_2:
            return State.EAT_TAIL_PHASE_3
        State.EAT_TAIL_PHASE_3:
            return State.NA_FINISHED
        State.EAT_WAVES:
            return State.EAT_WAVES
        State.HEAD_IN_PHASE_1_LEFT:
            return State.HEAD_IN_PHASE_2_LEFT
            
        State.HEAD_IN_PHASE_1_RIGHT:
            return State.HEAD_IN_PHASE_2_RIGHT
        State.HEAD_IN_PHASE_2_LEFT:
            return State.HEAD_OUT_LEFT
        State.HEAD_IN_PHASE_2_RIGHT:
            return State.HEAD_OUT_RIGHT
        State.HEAD_OUT_LEFT:
            return State.WAVES_LEFT
        State.HEAD_OUT_RIGHT:
            return State.WAVES_RIGHT
            
        State.TURN_LEFT_IN_PHASE_1:
            return State.TURN_LEFT_IN_PHASE_2
            
        State.TURN_LEFT_OUT_PHASE_1:
            return State.TURN_LEFT_OUT_PHASE_2
            
        State.TURN_LEFT_WAVES:
            return State.TURN_LEFT_WAVES
            
        State.TURN_RIGHT_IN_PHASE_1:
            return State.TURN_RIGHT_IN_PHASE_2
            
        State.TURN_RIGHT_OUT_PHASE_1:
            return State.TURN_RIGHT_OUT_PHASE_2
            
        State.TURN_RIGHT_WAVES:
            return State.TURN_RIGHT_WAVES
            
        State.WAVES_LEFT:
            return State.WAVES_LEFT
        State.WAVES_RIGHT:
            return State.WAVES_RIGHT
    
    return state


    # + State.NA_FINISHED,
    # + State.NA_DEAD,
    # + State.DEAD_LEFT,
    # + State.DEAD_RIGHT,
    # + State.EAT_PHASE_1_LEFT,
    # + State.EAT_PHASE_1_RIGHT,
    # + State.EAT_PHASE_2,
    # + State.EAT_TAIL_PHASE_1,
    # + State.EAT_TAIL_PHASE_2,
    # + State.EAT_TAIL_PHASE_3,
    # + State.EAT_WAVES,
    # + State.HEAD_IN_PHASE_1_LEFT,
    #   State.HEAD_IN_PHASE_1_MIDDLE,
    # + State.HEAD_IN_PHASE_1_RIGHT,
    # + State.HEAD_IN_PHASE_2_LEFT,
    # + State.HEAD_IN_PHASE_2_RIGHT,
    # + State.HEAD_OUT_LEFT,
    # + State.HEAD_OUT_RIGHT,
    #   State.TAIL_LEFT_PHASE_1,
    #   State.TAIL_LEFT_PHASE_2,
    #   State.TAIL_RIGHT_PHASE_1,
    #   State.TAIL_RIGHT_PHASE_2,
    # + State.TURN_LEFT_IN_PHASE_1,
    #   State.TURN_LEFT_IN_PHASE_2,
    # + State.TURN_LEFT_OUT_PHASE_1,
    #   State.TURN_LEFT_OUT_PHASE_2,
    #   State.TURN_LEFT_TAIL_PHASE_1,
    #   State.TURN_LEFT_TAIL_PHASE_2,
    # + State.TURN_LEFT_WAVES,
    # + State.TURN_RIGHT_IN_PHASE_1,
    #   State.TURN_RIGHT_IN_PHASE_2,
    # + State.TURN_RIGHT_OUT_PHASE_1,
    #   State.TURN_RIGHT_OUT_PHASE_2,
    #   State.TURN_RIGHT_TAIL_PHASE_1,
    #   State.TURN_RIGHT_TAIL_PHASE_2,
    # + State.TURN_RIGHT_WAVES,
    # + State.WAVES_LEFT,
    # + State.WAVES_RIGHT
