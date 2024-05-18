extends Area2D
signal hit

# Declare your variables using the @export allows us to set its value in the inspector
@export var speed = 400 #How fast the player will move (pixels per second)
var screen_size #Size of the Game Window


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Replace with function body.
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# We start by setting the velocity to (0, 0) 
	var velocity = Vector2.ZERO # The players movement Vector
	# Make sure you add the : to the end of the if statements
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# Flip the animation when walking 
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	if velocity.y > 0:
		$AnimatedSprite2D.flip_v = true
	else:
		$AnimatedSprite2D.flip_v = false


func _on_body_entered(body):
	hide() # Player disappears after being hit
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
