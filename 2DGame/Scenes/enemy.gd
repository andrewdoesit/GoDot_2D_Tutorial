extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# First we get the list of animation names from AnimationSprite2D this returns an array containing 
	# all three of the animation names ["walk", "swim", "fly"] 
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	#then pick a random number between 0 and 2 and select a name 
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# this makes the mobs delete themselves
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() 
