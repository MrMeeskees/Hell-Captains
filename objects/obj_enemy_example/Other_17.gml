/// obj_enemy_example - User Event 7 (Load)
/// Load enemy-specific data

if (ds_exists(other.loaded_extra_data, ds_type_map)) {
	if (ds_map_exists(other.loaded_extra_data, "health")) {
		health = other.loaded_extra_data[? "health"];
		max_health = other.loaded_extra_data[? "max_health"];
		speed_val = other.loaded_extra_data[? "speed_val"];
		direction_val = other.loaded_extra_data[? "direction_val"];
		ai_state = other.loaded_extra_data[? "ai_state"];
	}
}
