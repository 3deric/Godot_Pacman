class_name Controller
extends Node2D

var active_agent : Agent = null

func _unhandled_input(event: InputEvent) -> void:
	var click_position = get_global_mouse_position()
	if event.is_action_pressed("left_click"):
		var query = PhysicsPointQueryParameters2D.new()
		query.position = click_position
		query.collide_with_areas = true
		query.collide_with_bodies = true
		var result = get_world_2d().direct_space_state.intersect_point(query)
		if result.size() > 0:
			var clicked_object = result[0].collider
			active_agent = clicked_object
		elif active_agent != null:
			active_agent.set_move_target(click_position)
