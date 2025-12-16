/// obj_game_manager - Step Event
/// Handles global game logic

// Toggle pause menu
if (keyboard_check_pressed(vk_escape)) {
	// Check if menu already exists
	if (!instance_exists(obj_menu_controller)) {
		instance_create_depth(0, 0, -9999, obj_menu_controller);
	}
}
