class_name Agent
extends CharacterBody2D

const SPEED = 10.0

@onready var tile_map : TileMapLayer = $"../TileMapLayer"
@onready var astar : AStarGrid = $"../AStarGrid2D"

var current_path : Array[Vector2i]
var current_position : Vector2i

func _ready() -> void:
	current_position = global_position
	astar.set_point_occupied(tile_map.local_to_map(current_position))

func _physics_process(delta: float) -> void:
	if current_path.is_empty():
		return
	var target_position = tile_map.map_to_local(current_path.front())
	astar.set_point_empty(tile_map.local_to_map(current_position))
	astar.set_point_occupied(tile_map.local_to_map(target_position))
	global_position = global_position.move_toward(target_position, SPEED)
	if global_position == target_position:
		current_path.pop_front()
		current_position = global_position
		
func set_move_target(target : Vector2) -> void:
	if astar.is_point_movable(target):
		current_path = astar.get_movement_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(target)
		)		
		#print(current_path)
