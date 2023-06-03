extends CharacterBody2D

@onready var animation_player = $AnimationPlayer;
@onready var animation_tree = $AnimationTree;

const SPEED = 6000;
const FRICTION = 600;

enum {
	IDLE,
	RUNNING,
	ATTACKING,
}

var current_state = IDLE;

func _ready():
	pass

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized();
	
	if input_direction != Vector2.ZERO:
		current_state = RUNNING;
		velocity = input_direction * SPEED * delta;
		
		animation_tree.set("parameters/Idle/blend_position", input_direction);
		animation_tree.set("parameters/Run/blend_position", input_direction);

	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
		
	if velocity == Vector2.ZERO and current_state != ATTACKING:
		current_state = IDLE;
		
	match current_state:
		IDLE:
			idle();
		RUNNING:
			running();
		ATTACKING:
			attacking();
		
	move_and_slide();
	
func idle():
	animation_tree.get("parameters/playback").travel("Idle");
	
func running():
	animation_tree.get("parameters/playback").travel("Run");
	
func attacking():
	pass
