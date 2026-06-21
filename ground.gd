extends Node2D


@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 800
var height : int = 400 
@onready var tile_map = $TileMapLayer

var source_id = 0
var water_atlas = Vector2i(0,4)
var land_atlas = Vector2i(0,2)
var rock_atlas = Vector2i(0,0)


func _ready() -> void:
	noise = noise_height_text.noise 
	generate_world()
	


func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x, y)
			#print(noise_val)
			if noise_val > 0.0:
				#place
				tile_map.set_cell(Vector2(x,y), source_id, land_atlas)
			elif noise_val < -0.35:
				#place other
				tile_map.set_cell(Vector2(x,y), source_id, water_atlas)
			else:
				tile_map.set_cell(Vector2(x,y), source_id, rock_atlas)
	
