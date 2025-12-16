/// @description Saves the game to disk
/// @param {Real} slot Save slot number (0-2)
/// @return {Bool} True if save succeeded, false otherwise
function scr_save_game(_slot = 0) {
	try {
		// Build save data
		var save_map = scr_build_save_data();
		
		// Convert to JSON
		var json_string = json_encode(save_map);
		
		// Ensure save directory exists
		var save_dir = working_directory + "saves/";
		if (!directory_exists(save_dir)) {
			directory_create(save_dir);
		}
		
		// Write to file using buffer (more reliable than file_text_*)
		var filename = save_dir + "save" + string(_slot) + ".sav";
		var buffer = buffer_create(string_byte_length(json_string) + 1, buffer_fixed, 1);
		buffer_write(buffer, buffer_string, json_string);
		buffer_save(buffer, filename);
		buffer_delete(buffer);
		
		// Clean up DS structures to prevent memory leaks
		scr_destroy_save_data(save_map);
		
		show_debug_message("Game saved successfully to slot " + string(_slot));
		return true;
		
	} catch (e) {
		show_debug_message("Save failed: " + string(e.message));
		return false;
	}
}
