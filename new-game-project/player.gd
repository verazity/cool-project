extends CharacterBody2D
@onready var slash = $SlashTemp
@onready var can_attack = true

const SPEED = 300.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("player_attack") and can_attack==true:
		can_attack = false
		slash.look_at(get_global_mouse_position())
		slash.visible = true
		$SlashTemp/Area2D.monitoring = true
		$SlashTemp/Area2D.monitorable = true
		
		await get_tree().create_timer(.4).timeout
		
		slash.visible = false
		$SlashTemp/Area2D.monitoring = false
		$SlashTemp/Area2D.monitorable = false
		can_attack = true

	move_and_slide()
