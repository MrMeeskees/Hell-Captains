# Setup Guide

Step-by-step instructions for implementing the save/load system in your GameMaker Studio 2 project.

## Step 1: Import Scripts

Import all scripts from the `scripts/` folder into your project:

1. Right-click on "Scripts" in the Asset Browser
2. Select "Create" → "Script"
3. Copy the content from each `.gml` file:
   - `scr_build_save_data`
   - `scr_save_game`
   - `scr_load_game`
   - `scr_restore_instances`
   - `scr_destroy_save_data`
   - `scr_save_exists`
   - `scr_debug_save_system`
   - `enum_menu_state`

## Step 2: Create Objects

### A. Create obj_saveable (Parent Object)

1. Right-click "Objects" → "Create" → "Object"
2. Name it `obj_saveable`
3. Add events:
   - **Create Event**: Copy from `objects/obj_saveable/Create_0.gml`
   - **Other → User Event 6**: Copy from `objects/obj_saveable/Other_16.gml`
   - **Other → User Event 7**: Copy from `objects/obj_saveable/Other_17.gml`

### B. Create obj_game_manager

1. Create object named `obj_game_manager`
2. Set **Persistent** to `true` in object properties
3. Add events:
   - **Create Event**: `objects/obj_game_manager/Create_0.gml`
   - **Step Event**: `objects/obj_game_manager/Step_0.gml`
   - **Room Start**: `objects/obj_game_manager/Other_4.gml`

### C. Create obj_menu_controller

1. Create object named `obj_menu_controller`
2. Add events:
   - **Create Event**: `objects/obj_menu_controller/Create_0.gml`
   - **Step Event**: `objects/obj_menu_controller/Step_0.gml`
   - **Draw GUI**: `objects/obj_menu_controller/Draw_64.gml`
   - **Destroy**: `objects/obj_menu_controller/Destroy_0.gml`

### D. Create obj_enemy_example (Optional)

This is an example showing how to implement save/load for your objects:

1. Create object named `obj_enemy_example`
2. Set **Parent** to `obj_saveable`
3. Add events:
   - **Create Event**: `objects/obj_enemy_example/Create_0.gml`
   - **Other → User Event 6**: `objects/obj_enemy_example/Other_16.gml`
   - **Other → User Event 7**: `objects/obj_enemy_example/Other_17.gml`

## Step 3: Place Game Manager in Room

1. Open your first room (usually `rm_main` or `rm_menu`)
2. Drag `obj_game_manager` into the room
3. Position doesn't matter (it's non-visual)
4. This instance will persist through all rooms

## Step 4: Make Your Objects Saveable

For each gameplay object you want to save:

### Example: obj_player

1. Open `obj_player` properties
2. Set **Parent** to `obj_saveable`
3. Add **User Event 6** (save):
   ```gml
   // obj_player - User Event 6
   other.extra_data[? "health"] = health;
   other.extra_data[? "max_health"] = max_health;
   other.extra_data[? "speed"] = speed;
   // Add any other variables you need to save
   ```
4. Add **User Event 7** (load):
   ```gml
   // obj_player - User Event 7
   if (ds_exists(other.loaded_extra_data, ds_type_map)) {
       health = other.loaded_extra_data[? "health"];
       max_health = other.loaded_extra_data[? "max_health"];
       speed = other.loaded_extra_data[? "speed"];
   }
   ```

Repeat for all gameplay objects: enemies, items, NPCs, etc.

## Step 5: Initialize Global Variables

The system expects these global variables to exist. They're initialized in `obj_game_manager`, but you can customize them:

```gml
// In obj_game_manager Create Event
global.player_health = 100;
global.player_max_health = 100;
global.player_score = 0;
global.current_level = 1;
global.volume = 1.0;
```

Add any additional global variables you need, then update:
- `scr_build_save_data` (to save them)
- `scr_load_game` (to load them)

## Step 6: Test the System

### Basic Test

1. Run your game
2. Press **ESC** to open pause menu
3. Select "Save Game"
4. You should see "Game Saved!" message
5. Close the game
6. Restart and press **F5** to open debug console
7. Type: `scr_load_game(0)`
8. Your game state should restore

### Debug Console Test

While game is running, open debug console (F5) and run:

```gml
scr_debug_test_save_load();
```

This will test the save/load cycle and show results in the console.

## Step 7: Customize (Optional)

### Add More Global Variables

In `scr_build_save_data`:
```gml
save_map[? "player_name"] = global.player_name;
save_map[? "quest_progress"] = global.quest_progress;
```

In `scr_load_game`:
```gml
global.player_name = save_map[? "player_name"];
global.quest_progress = save_map[? "quest_progress"];
```

### Change Save Location

In `scr_save_game` and `scr_load_game`:
```gml
var save_dir = working_directory + "my_saves/";
```

### Add Menu Options

In `obj_menu_controller` Create Event:
```gml
main_menu_items = ["Resume", "Save", "Load", "Settings", "Quit"];
```

Then add handling in Step Event.

## Step 8: Exclude Objects from Saving

Some objects shouldn't be saved (GUI, effects, etc.):

In `scr_build_save_data`, objects are filtered:
```gml
if (obj_name != "obj_gui" && 
    obj_name != "obj_menu_controller" && 
    obj_name != "obj_game_manager" &&
    object_is_ancestor(object_index, obj_saveable)) {
    // Save this instance
}
```

Add any objects you want to exclude to this condition.

## Troubleshooting

### "Save Failed!" Message
- Check debug console (F5) for error details
- Ensure `obj_game_manager` exists in room
- Verify global variables are initialized

### Objects Not Restoring
- Confirm object inherits from `obj_saveable`
- Check User Event 6 and 7 are implemented
- Verify object name hasn't changed

### Menu Not Opening
- Ensure `obj_game_manager` is in the room
- Check that ESC key isn't used elsewhere
- Verify `obj_menu_controller` exists in project

### Volume Not Working
- Confirm `global.volume` is initialized
- Check audio_master_gain is called
- Ensure you have audio in your game

## Next Steps

1. ✅ Run through [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)
2. ✅ Read [SAVE_SYSTEM_README.md](SAVE_SYSTEM_README.md) for details
3. ✅ Customize the system for your game
4. ✅ Add load menu to main menu
5. ✅ Add autosave functionality
6. ✅ Implement save slot selection UI

## Support

For issues or questions:
1. Check the debug console for error messages
2. Review the example implementation in `obj_enemy_example`
3. Use debug functions: `scr_debug_print_save(0)` to inspect saves
4. Refer to [QUICK_REFERENCE.md](QUICK_REFERENCE.md)

## Checklist

- [ ] All scripts imported
- [ ] obj_saveable created
- [ ] obj_game_manager created and placed in room
- [ ] obj_menu_controller created
- [ ] Gameplay objects inherit from obj_saveable
- [ ] User Events 6 & 7 implemented for custom objects
- [ ] Global variables initialized
- [ ] System tested with debug functions
- [ ] Save/load cycle works correctly
- [ ] Pause menu opens with ESC
- [ ] Volume control works

Once all items are checked, you're ready to go! 🎮
