/// obj_menu_controller - Create Event
/// Initializes the pause menu

// Menu state
menu_state = enum_menu_state.MAIN;
selected_item = 0;

// Main menu items
main_menu_items = ["Resume", "Save Game", "Sound Settings", "Exit Game"];
main_menu_count = array_length(main_menu_items);

// Sound menu items
sound_menu_items = ["Volume: " + string(floor(global.volume * 100)) + "%", "Back"];
sound_menu_count = array_length(sound_menu_items);

// UI settings
menu_x = display_get_gui_width() / 2;
menu_y = display_get_gui_height() / 2 - 60;
menu_item_height = 40;

// Feedback messages
message = "";
message_timer = 0;
message_duration = 90; // 1.5 seconds at 60 FPS

// Pause the game
instance_deactivate_all(true);
instance_activate_object(obj_menu_controller);
instance_activate_object(obj_game_manager);
