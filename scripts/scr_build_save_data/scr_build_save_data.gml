/// @description Builds the complete save data structure
/// @return {Id.DsMap} DS map containing all save data
function scr_build_save_data() {
	var save_map = ds_map_create();
	
	// Save global variables
	save_map[? "player_health"] = global.player_health;
	save_map[? "player_max_health"] = global.player_max_health;
	save_map[? "player_score"] = global.player_score;
	save_map[? "current_level"] = global.current_level;
	save_map[? "volume"] = global.volume;
	save_map[? "current_room"] = room_get_name(room);
	
	// Build instance list
	var obj_list = ds_list_create();
	with (all) {
		// Skip GUI, menu, and persistent objects
		var obj_name = object_get_name(object_index);
		if (obj_name != "obj_gui" && 
		    obj_name != "obj_menu_controller" && 
		    obj_name != "obj_game_manager" &&
			object_is_ancestor(object_index, obj_saveable)) {
			
			var inst_data = ds_map_create();
			inst_data[? "object_name"] = obj_name;
			inst_data[? "x"] = x;
			inst_data[? "y"] = y;
			inst_data[? "image_xscale"] = image_xscale;
			inst_data[? "image_yscale"] = image_yscale;
			inst_data[? "image_angle"] = image_angle;
			
			// Trigger user-defined save event (User Event 6)
			// Objects should populate other.extra_data in this event
			other.extra_data = ds_map_create();
			event_user(6);
			inst_data[? "extra_data"] = other.extra_data;
			
			ds_list_add(obj_list, inst_data);
		}
	}
	save_map[? "instances"] = obj_list;
	
	return save_map;
}
