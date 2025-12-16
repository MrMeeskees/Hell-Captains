/// obj_menu_controller - Step Event
/// Handles menu input and logic

// Update message timer
if (message_timer > 0) {
	message_timer--;
	if (message_timer == 0) {
		message = "";
	}
}

// Handle input based on menu state
switch (menu_state) {
	case enum_menu_state.MAIN:
		// Navigate menu
		if (keyboard_check_pressed(vk_up)) {
			selected_item--;
			if (selected_item < 0) {
				selected_item = main_menu_count - 1;
			}
		}
		
		if (keyboard_check_pressed(vk_down)) {
			selected_item++;
			if (selected_item >= main_menu_count) {
				selected_item = 0;
			}
		}
		
		// Select menu item
		if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
			switch (selected_item) {
				case 0: // Resume
					instance_destroy();
					break;
					
				case 1: // Save Game
					if (scr_save_game(0)) {
						message = "Game Saved!";
						message_timer = message_duration;
					} else {
						message = "Save Failed!";
						message_timer = message_duration;
					}
					break;
					
				case 2: // Sound Settings
					menu_state = enum_menu_state.SOUND;
					selected_item = 0;
					break;
					
				case 3: // Exit Game
					game_end();
					break;
			}
		}
		
		// Close menu with Escape
		if (keyboard_check_pressed(vk_escape)) {
			instance_destroy();
		}
		break;
		
	case enum_menu_state.SOUND:
		// Navigate sound menu
		if (keyboard_check_pressed(vk_up)) {
			selected_item--;
			if (selected_item < 0) {
				selected_item = sound_menu_count - 1;
			}
		}
		
		if (keyboard_check_pressed(vk_down)) {
			selected_item++;
			if (selected_item >= sound_menu_count) {
				selected_item = 0;
			}
		}
		
		// Adjust volume with left/right
		if (selected_item == 0) {
			var volume_changed = false;
			
			if (keyboard_check_pressed(vk_left)) {
				global.volume = max(0, global.volume - 0.1);
				volume_changed = true;
			}
			
			if (keyboard_check_pressed(vk_right)) {
				global.volume = min(1, global.volume + 0.1);
				volume_changed = true;
			}
			
			if (volume_changed) {
				audio_master_gain(global.volume);
				sound_menu_items[0] = "Volume: " + string(floor(global.volume * 100)) + "%";
			}
		}
		
		// Select menu item
		if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
			switch (selected_item) {
				case 0: // Volume (do nothing, adjusted with arrows)
					break;
					
				case 1: // Back
					menu_state = enum_menu_state.MAIN;
					selected_item = 0;
					break;
			}
		}
		
		// Back to main menu with Escape
		if (keyboard_check_pressed(vk_escape)) {
			menu_state = enum_menu_state.MAIN;
			selected_item = 0;
		}
		break;
}
