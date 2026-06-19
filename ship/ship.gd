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
		
		move_and_slide()
	
func deploy_drill():
	if Input.is_action_just_pressed("deploy") and is_drill_deployed == false:
		is_drill_deployed = true
		deploy.emit($DeployMarker.global_position, 300) # Signal emits from the Ship to the Level
