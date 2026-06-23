extends Node2D


@export var noise_height_text : NoiseTexture2D
var noise : Noise

@onready var marker1 = $Marker1
@onready var marker2 = $Marker2



@onready var tile_map = $TileMapLayer

@onready var background = get_tree().get_first_node_in_group("Background")

@onready var width : int = background.size.x / 128
@onready var height : int = background.size.y / 64

var source_id = 0
var water_atlas = Vector2i(0,4)
var land_atlas = Vector2i(0,2)
var rock_atlas = Vector2i(0,0)


func _ready() -> void:
	noise = noise_height_text.noise 
	
	
	print("width: " + str(width))
	print("height: " + str(height))
	generate_world()
	


func generate_world():
	tile_map.clear()
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
	
