/// @description Loads the game from disk
/// @param {Real} slot Save slot number (0-2)
/// @return {Bool} True if load succeeded, false otherwise
function scr_load_game(_slot = 0) {
	var filename = working_directory + "saves/save" + string(_slot) + ".sav";
	
	// Check if save file exists
	if (!file_exists(filename)) {
		show_debug_message("Save file not found: " + filename);
		return false;
	}
	
	try {
		// Read file using buffer
		var buffer = buffer_load(filename);
		var json_string = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
		
		// Decode JSON to DS map
		var save_map = json_decode(json_string);
		
		if (save_map == -1) {
			show_debug_message("Failed to decode save data");
			return false;
		}
		
		// Restore global variables
		global.player_health = save_map[? "player_health"];
		global.player_max_health = save_map[? "player_max_health"];
		global.player_score = save_map[? "player_score"];
		global.current_level = save_map[? "current_level"];
		global.volume = save_map[? "volume"];
		
		// Apply volume setting
		audio_master_gain(global.volume);
		
		// Get target room
		var target_room_name = save_map[? "current_room"];
		var target_room = asset_get_index(target_room_name);
		
		// Store instance data for restoration after room change
		global.instances_to_restore = save_map[? "instances"];
		
		// Go to saved room (instances will be restored in room start event)
		if (room != target_room) {
			room_goto(target_room);
		} else {
			// Already in the room, restore immediately
			scr_restore_instances();
		}
		
		// Note: Don't destroy save_map here - it's destroyed after instances are restored
		show_debug_message("Game loaded successfully from slot " + string(_slot));
		return true;
		
	} catch (e) {
		show_debug_message("Load failed: " + string(e.message));
		return false;
	}
}
