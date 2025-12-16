/// @description Debug utilities for save/load system
/// Call these functions to test and debug the save system

/// @description Prints save data to console for debugging
/// @param {Real} slot Save slot to inspect
function scr_debug_print_save(_slot = 0) {
	var filename = working_directory + "saves/save" + string(_slot) + ".sav";
	
	if (!file_exists(filename)) {
		show_debug_message("No save file found in slot " + string(_slot));
		return;
	}
	
	var buffer = buffer_load(filename);
	var json_string = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	show_debug_message("=== Save Slot " + string(_slot) + " ===");
	show_debug_message(json_string);
	show_debug_message("=== End Save Data ===");
}

/// @description Lists all available save files
function scr_debug_list_saves() {
	show_debug_message("=== Available Saves ===");
	for (var i = 0; i < 3; i++) {
		if (scr_save_exists(i)) {
			var filename = working_directory + "saves/save" + string(i) + ".sav";
			var size = file_text_open_read(filename);
			file_text_close(size);
			show_debug_message("Slot " + string(i) + ": EXISTS");
		} else {
			show_debug_message("Slot " + string(i) + ": EMPTY");
		}
	}
	show_debug_message("=== End List ===");
}

/// @description Deletes a save file
/// @param {Real} slot Save slot to delete
function scr_debug_delete_save(_slot = 0) {
	var filename = working_directory + "saves/save" + string(_slot) + ".sav";
	
	if (file_exists(filename)) {
		file_delete(filename);
		show_debug_message("Deleted save slot " + string(_slot));
		return true;
	} else {
		show_debug_message("No save file in slot " + string(_slot));
		return false;
	}
}

/// @description Tests save/load cycle
function scr_debug_test_save_load() {
	show_debug_message("=== Testing Save/Load ===");
	
	// Save
	show_debug_message("Saving to slot 0...");
	if (scr_save_game(0)) {
		show_debug_message("Save successful!");
	} else {
		show_debug_message("Save failed!");
		return;
	}
	
	// Store current values
	var old_health = global.player_health;
	var old_score = global.player_score;
	
	// Modify values
	global.player_health = 50;
	global.player_score = 9999;
	show_debug_message("Modified: health=" + string(global.player_health) + ", score=" + string(global.player_score));
	
	// Load
	show_debug_message("Loading from slot 0...");
	if (scr_load_game(0)) {
		show_debug_message("Load successful!");
		show_debug_message("Restored: health=" + string(global.player_health) + ", score=" + string(global.player_score));
	} else {
		show_debug_message("Load failed!");
	}
	
	show_debug_message("=== Test Complete ===");
}
