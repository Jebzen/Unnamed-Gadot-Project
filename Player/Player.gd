extends CharacterBody2D

@export var ACCELERATION = 10
@export var MAX_SPEED = 75
@export var FRICTION = 500
@export var ROLL_SPEED = 125

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var roll_vector = Vector2.DOWN
var stats = PlayerStats

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $HitboxPivot/SwordHitbox
@onready var hurtBox = $Hurtbox

func _ready():
	#animation_finished.connect(_on_animation_finished)
	stats.connect("no_health", queue_free)
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = roll_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED * delta)
	else:
		if velocity.length() > FRICTION * delta:
			velocity -= velocity.normalized() * FRICTION * delta
		else:
			animationState.travel("Idle")
			velocity = Vector2.ZERO
			
	move()
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func roll_state(delta):
	velocity = roll_vector * 2.5
	animationState.travel("Roll")
	move()
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	move_and_collide(velocity)
	move_and_slide()
	
func attack_animation_finished():
	velocity = velocity * 0.8
	state = MOVE
	
func roll_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE
	
func _on_hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(1)
	hurtBox.create_hit_effect()
