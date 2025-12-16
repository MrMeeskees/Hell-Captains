# Hell-Captains

A GameMaker Studio 2 project featuring a complete save/load system, pause menu, and sound settings implementation.

## 📊 Project Stats

- **Scripts**: 8 GML scripts
- **Objects**: 4 objects (13 event files)
- **Documentation**: 8 comprehensive guides
- **Total Files**: 29
- **Save Slots**: 3 (expandable)
- **Setup Time**: ~5 minutes

## Features

### 💾 Save/Load System
- DS Map-based save structure with JSON encoding
- Automatic instance recreation with full property restoration
- Multiple save slots (expandable)
- Custom variable support via User Events
- Memory leak prevention with proper cleanup
- Error handling for corrupt or missing files

### ⏸️ Pause Menu
- Instance deactivation for true game pause
- State machine-based navigation
- Visual feedback with selection highlighting
- Semi-transparent overlay
- Save confirmation messages

### 🔊 Sound Settings
- Master volume control (0-100%)
- Real-time adjustment
- Persistent settings saved with game data
- Visual percentage display

## Quick Start

**⚡ [5-Minute Setup Guide](GETTING_STARTED.md)** - Get running fast!

1. **Add Game Manager**: Place `obj_game_manager` in your first room
2. **Make Objects Saveable**: Set parent to `obj_saveable` and implement User Events 6 & 7
3. **Test**: Press ESC to open pause menu, save/load game

## Documentation

- [**🚀 Getting Started**](GETTING_STARTED.md) - 5-minute quick start guide
- [**📖 Save System README**](SAVE_SYSTEM_README.md) - Complete system documentation
- [**⚡ Quick Reference**](QUICK_REFERENCE.md) - API reference and examples
- [**🔧 Setup Guide**](SETUP_GUIDE.md) - Detailed setup instructions
- [**✅ Testing Checklist**](TESTING_CHECKLIST.md) - Comprehensive test plan
- [**📐 Architecture**](ARCHITECTURE.md) - System diagrams and flow charts
- [**📑 File Index**](FILE_INDEX.md) - Complete file reference

## Project Structure

```
Hell-Captains/
├── scripts/
│   ├── scr_build_save_data/      # Build save data structure
│   ├── scr_save_game/            # Save to disk
│   ├── scr_load_game/            # Load from disk
│   ├── scr_restore_instances/    # Recreate saved instances
│   ├── scr_destroy_save_data/    # Memory cleanup
│   ├── scr_save_exists/          # Check save file
│   ├── scr_debug_save_system/    # Debug utilities
│   └── enum_menu_state/          # Menu state enum
├── objects/
│   ├── obj_game_manager/         # Persistent game state
│   ├── obj_menu_controller/      # Pause menu
│   ├── obj_saveable/             # Base saveable object
│   └── obj_enemy_example/        # Example implementation
└── saves/                        # Save files (auto-created)
    ├── save0.sav
    ├── save1.sav
    └── save2.sav
```

## Usage Examples

### Save Game
```gml
scr_save_game(0); // Save to slot 0
```

### Load Game
```gml
if (scr_save_exists(0)) {
    scr_load_game(0);
}
```

### Make Object Saveable
```gml
// Set parent to obj_saveable

// User Event 6 - Save
other.extra_data[? "health"] = health;
other.extra_data[? "ammo"] = ammo;

// User Event 7 - Load
if (ds_exists(other.loaded_extra_data, ds_type_map)) {
    health = other.loaded_extra_data[? "health"];
    ammo = other.loaded_extra_data[? "ammo"];
}
```

## Global Variables

Auto-saved variables:
- `global.player_health` - Current health
- `global.player_max_health` - Maximum health
- `global.player_score` - Player score
- `global.current_level` - Current level
- `global.volume` - Audio volume (0.0-1.0)

## Controls

**Pause Menu**
- `ESC` - Open/close
- `↑/↓` - Navigate
- `Enter/Space` - Select

**Sound Settings**
- `←/→` - Adjust volume

## GameMaker Conventions

Following GML best practices:
- `obj_*` for objects
- `scr_*` for scripts
- `enum_*` for enumerations
- Proper DS structure cleanup
- Try-catch error handling

## Technical Details

- **Save Format**: JSON-encoded DS maps
- **Save Location**: `working_directory + "saves/"`
- **Instance Saving**: Via User Event 6
- **Instance Loading**: Via User Event 7
- **Pause Method**: Instance deactivation

## Debug Commands

```gml
scr_debug_print_save(0);      // Print save data
scr_debug_list_saves();       // List all saves
scr_debug_delete_save(0);     // Delete a save
scr_debug_test_save_load();   // Test save/load cycle
```

## Requirements

- GameMaker Studio 2 (GMS2)
- GML (GameMaker Language)

## License

This project is provided as-is for educational and development purposes.