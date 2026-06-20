extends CharacterBody2D

signal deploy(position, velocity)

const SPEED = 200.0
var is_drill_deployed = false


func _physics_process(_delta: float) -> void:
	
	deploy_drill()
	movement()

func movement():
	if is_drill_deployed == false:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		slight_rotation()
		move_and_slide()

func slight_rotation(): # FIX!
	if Input.is_action_pressed("ui_right"):
		if $".".rotation < 0.3:
			$".".rotate(0.008)
	elif Input.is_action_pressed("ui_left"):
		if $".".rotation > -0.3:
			$".".rotate(-0.008)
	else:
		if $".".rotation > 0.1:
			$".".rotate(-0.012)
		elif $".".rotation < 0.1:
			$".".rotate(0.012)

func deploy_drill():
	if Input.is_action_just_pressed("deploy") and is_drill_deployed == false:
		is_drill_deployed = true
		deploy.emit($DeployMarker.global_position, 600) # Signal emits from the Ship to the Level

func _on_level_free_ship() -> void:
	is_drill_deployed = false
