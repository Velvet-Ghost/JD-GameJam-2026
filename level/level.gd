extends Node2D

signal free_ship

var drill_scene = load("res://ship/drill.tscn")
	

func _ready() -> void:
	$Camera.reparent($Ship)

func _process(_delta: float) -> void:
	pass

func _on_ship_deploy(pos: Variant, vel: Variant):
	spawn_drill(pos, vel)

func spawn_drill(pos, vel):
	var drill = drill_scene.instantiate() as CharacterBody2D
	drill.position = pos
	drill.velocity.y = vel
	$".".add_child(drill)
	get_node("Drill").despawn.connect(_on_drill_despawn) # Despawn signal gets connected from Drill to Level
	camera_on_drill()

func _on_drill_despawn():
	emit_signal("free_ship")
	camera_on_ship()

func camera_on_ship():
	$Drill/Camera.reparent($"."/Ship)
	var cam = $Ship/Camera
	cam.offset.y = 200
	cam.position.x = 0
	cam.position.y = 0
	cam.zoom.x = 1.2
	cam.zoom.y = 1.2
	
func camera_on_drill():
	$Ship/Camera.reparent($"."/Drill)
	var cam = $Drill/Camera
	cam.offset.y = 80
	cam.zoom.x = 1.4
	cam.zoom.y = 1.4
