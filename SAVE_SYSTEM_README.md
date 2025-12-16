# Hell Captains - Save/Load & Menu System

A complete save/load system and pause menu implementation for GameMaker Studio 2 using GML.

## Project Structure

### Scripts
- **scr_build_save_data**: Gathers all game state into a DS map
- **scr_save_game**: Saves game data to disk as JSON
- **scr_load_game**: Loads game data from disk
- **scr_restore_instances**: Recreates saved instances after loading
- **scr_destroy_save_data**: Cleans up DS structures to prevent memory leaks
- **scr_save_exists**: Checks if a save file exists
- **enum_menu_state**: Menu state enumeration (MAIN, SOUND, CONFIRM)

### Objects
- **obj_game_manager**: Persistent game manager (handles global state, pause menu toggle)
- **obj_menu_controller**: Pause menu controller with save/sound/exit options
- **obj_saveable**: Base parent object for all saveable game objects
- **obj_enemy_example**: Example enemy implementation showing save/load usage

## Setup Instructions

### 1. Add obj_game_manager to Your First Room
Place one instance of `obj_game_manager` in your first room. It will persist across all rooms.

### 2. Make Objects Saveable
For any object you want to save:
1. Set its parent to `obj_saveable`
2. Implement User Event 6 (save) to store custom variables
3. Implement User Event 7 (load) to restore custom variables

Example (see obj_enemy_example):
```gml
// User Event 6 - Save
other.extra_data[? "health"] = health;
other.extra_data[? "ai_state"] = ai_state;

// User Event 7 - Load
if (ds_exists(other.loaded_extra_data, ds_type_map)) {
    health = other.loaded_extra_data[? "health"];
    ai_state = other.loaded_extra_data[? "ai_state"];
}
```

### 3. Using the Pause Menu
- Press **ESC** to open the pause menu
- Use **Up/Down arrows** to navigate
- Press **Enter/Space** to select
- In sound settings, use **Left/Right arrows** to adjust volume

### 4. Save System Usage

#### Save the game:
```gml
scr_save_game(0); // Save to slot 0 (0-2)
```

#### Load the game:
```gml
scr_load_game(0); // Load from slot 0
```

#### Check if save exists:
```gml
if (scr_save_exists(0)) {
    // Save file exists
}
```

## Global Variables

The following global variables are automatically saved/loaded:
- `global.player_health` - Player's current health
- `global.player_max_health` - Player's maximum health
- `global.player_score` - Player's score
- `global.current_level` - Current level/stage
- `global.volume` - Audio volume (0.0 to 1.0)

Add more global variables in [scr_build_save_data](scripts/scr_build_save_data/scr_build_save_data.gml) and [scr_load_game](scripts/scr_load_game/scr_load_game.gml).

## Features

### Save/Load System
- **DS Map-based** save structure with JSON encoding
- **Automatic instance recreation** with position and properties
- **Custom variable support** via User Events 6 & 7
- **Error handling** for missing files and corrupt data
- **Memory leak prevention** with proper DS structure cleanup
- **Multiple save slots** (0-2 by default, expandable)

### Pause Menu
- **Instance deactivation** method for true game pause
- **State machine** for menu navigation (Main → Sound → Confirm)
- **Visual feedback** with highlighted selection
- **Semi-transparent overlay** darkens game behind menu
- **Save feedback** shows success/failure messages

### Sound Settings
- **Master volume control** using GameMaker's audio API
- **Real-time adjustment** with keyboard input
- **Persistent settings** saved with game data
- **Visual percentage display** (0% - 100%)

## Technical Details

### Save File Format
- **Location**: `working_directory + "saves/save0.sav"`
- **Format**: JSON encoded DS map
- **Encoding**: Uses `json_encode()` for DS maps/lists
- **Reading**: Uses buffer functions for reliability

### Instance Saving Logic
1. Loop through all instances
2. Skip non-saveable objects (GUI, menus, managers)
3. Check if object inherits from `obj_saveable`
4. Store object name, position, and sprite properties
5. Trigger User Event 6 to gather custom data
6. Add to instances list

### Instance Loading Logic
1. Read and decode save file
2. Restore global variables
3. Store instance list globally
4. Navigate to saved room
5. In Room Start event, destroy existing gameplay objects
6. Recreate each saved instance
7. Trigger User Event 7 to restore custom data
8. Clean up DS structures

## Best Practices

### Memory Management
- Always destroy DS structures after use
- Use `scr_destroy_save_data()` after saving
- Clean up is automatic when loading

### Error Handling
- Check if save exists before loading
- Try-catch blocks prevent crashes
- Debug messages log save/load operations

### Object Hierarchy
```
obj_saveable (parent)
    ├── obj_enemy_example
    ├── obj_player
    ├── obj_item
    └── [your gameplay objects]
```

### Excluded from Saving
- GUI objects
- Menu controllers
- Game manager (persistent)
- Any object not inheriting from `obj_saveable`

## Customization

### Add More Menu Options
Edit [obj_menu_controller Create Event](objects/obj_menu_controller/Create_0.gml):
```gml
main_menu_items = ["Resume", "Save Game", "Load Game", "Sound Settings", "Exit Game"];
```

Then add handling in [Step Event](objects/obj_menu_controller/Step_0.gml).

### Change Save Location
Edit `scr_save_game` and `scr_load_game`:
```gml
var save_dir = working_directory + "my_custom_saves/";
```

### Adjust Volume Increment
In [obj_menu_controller Step Event](objects/obj_menu_controller/Step_0.gml):
```gml
global.volume = max(0, global.volume - 0.05); // Smaller increments
```

## Naming Conventions

Following GameMaker Studio 2 best practices:
- **Objects**: `obj_*` (e.g., obj_menu_controller)
- **Scripts**: `scr_*` (e.g., scr_save_game)
- **Enums**: `enum_*` (e.g., enum_menu_state)
- **Events**: GML event files in object folders

## License

This implementation is provided as-is for use in GameMaker Studio 2 projects.
