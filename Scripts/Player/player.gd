extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_input = Input.get_axis("left", "right");
	var y_input = Input.get_axis("up", "down");
	
	velocity.x = x_input * SPEED;
	velocity.y = y_input * SPEED;
	
	if x_input == 0 and y_input == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		velocity.y = move_toward(velocity.x, 0, SPEED);

	move_and_slide();
