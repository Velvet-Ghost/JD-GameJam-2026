extends CharacterBody2D

signal despawn

const SPEED = 300.0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	movement()

func movement():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	slight_rotation()
	move_and_slide()

func slight_rotation():
	if Input.is_action_pressed("ui_left"):
		if $".".rotation < 0.3:
			$".".rotate(0.008)
	elif Input.is_action_pressed("ui_right"):
		if $".".rotation > -0.3:
			$".".rotate(-0.008)
	else:
		if $".".rotation > 0:
			$".".rotate(-0.012)
		elif $".".rotation < 0:
			$".".rotate(0.012)

func _on_death_timer_timeout() -> void:
	_despawn()

func _despawn():
	despawn.emit()
	queue_free()
