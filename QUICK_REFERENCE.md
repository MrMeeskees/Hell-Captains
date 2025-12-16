# Quick Reference Guide

## For Developers

### Making an Object Saveable

1. **Set parent to obj_saveable**
2. **Add User Event 6 (save data)**
   ```gml
   other.extra_data[? "my_var"] = my_var;
   ```
3. **Add User Event 7 (load data)**
   ```gml
   if (ds_exists(other.loaded_extra_data, ds_type_map)) {
       my_var = other.loaded_extra_data[? "my_var"];
   }
   ```

### Function Reference

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| `scr_save_game(slot)` | slot (0-2) | bool | Saves game to slot |
| `scr_load_game(slot)` | slot (0-2) | bool | Loads game from slot |
| `scr_save_exists(slot)` | slot (0-2) | bool | Checks if save exists |
| `scr_build_save_data()` | none | DsMap | Builds save data map |
| `scr_restore_instances()` | none | none | Restores saved instances |

### Global Variables (Auto-Saved)

```gml
global.player_health       // Current health
global.player_max_health   // Max health
global.player_score        // Score
global.current_level       // Level number
global.volume              // Audio volume (0-1)
```

### Menu States

```gml
enum enum_menu_state {
    MAIN,      // Main pause menu
    SOUND,     // Sound settings submenu
    CONFIRM    // Confirmation dialogs
}
```

## For Players

### Controls

**Pause Menu**
- `ESC` - Open/close pause menu
- `↑/↓` - Navigate menu
- `Enter/Space` - Select option

**Sound Settings**
- `←/→` - Decrease/increase volume
- `Enter` - Confirm
- `ESC` - Go back

### Menu Options

**Main Menu**
- Resume - Return to game
- Save Game - Save current progress
- Sound Settings - Adjust audio
- Exit Game - Quit to desktop

**Sound Menu**
- Volume - Adjust master volume (0-100%)
- Back - Return to main menu

## File Locations

- **Save files**: `working_directory/saves/save[0-2].sav`
- **Format**: JSON-encoded DS maps
- **Persistence**: Survives game restarts

## Common Issues & Solutions

### Save not working?
- Check if `obj_game_manager` exists in the room
- Verify global variables are initialized
- Check debug console for error messages

### Objects not restoring?
- Ensure object inherits from `obj_saveable`
- Implement both User Event 6 (save) and 7 (load)
- Check object name hasn't changed

### Volume not saving?
- Verify `global.volume` is set in game manager
- Ensure save/load includes volume variable
- Check audio_master_gain is called after loading

## Example Implementation

```gml
// In obj_player Create Event
event_inherited(); // Call parent (obj_saveable) create

health = 100;
ammo = 50;
inventory = ds_list_create();

// User Event 6 - Save
other.extra_data[? "health"] = health;
other.extra_data[? "ammo"] = ammo;
// Note: DS lists need special handling, convert to array

// User Event 7 - Load
if (ds_exists(other.loaded_extra_data, ds_type_map)) {
    health = other.loaded_extra_data[? "health"];
    ammo = other.loaded_extra_data[? "ammo"];
}
```

## Tips

- Save before major events/boss fights
- Use multiple save slots for safety
- Test save/load frequently during development
- Clean up DS structures to prevent memory leaks
- Use descriptive variable names in save data
