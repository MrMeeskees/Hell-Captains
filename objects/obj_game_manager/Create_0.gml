/// obj_game_manager - Create Event
/// Initializes global game variables

// Mark as persistent so it survives room changes
persistent = true;

// Initialize global variables
global.player_health = 100;
global.player_max_health = 100;
global.player_score = 0;
global.current_level = 1;
global.volume = 1.0;

// Apply initial volume
audio_master_gain(global.volume);

// Try to load settings if they exist
if (scr_save_exists(0)) {
	// Auto-load could be implemented here if desired
	// scr_load_game(0);
}
