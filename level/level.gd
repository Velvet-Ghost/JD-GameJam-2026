extends Node2D

var drill_scene = load("res://ship/drill.tscn")

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass


func _on_ship_deploy(pos: Variant, vel: Variant):
	spawn_drill(pos, vel)

func spawn_drill(pos, vel):
	var drill = drill_scene.instantiate() as CharacterBody2D
	drill.position = pos
	#drill.velocity = vel
	$Drill.add_child(drill)
	
