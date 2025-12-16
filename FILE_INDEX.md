# File Index

Complete reference of all files in the Hell Captains save/load system.

## Documentation Files (6)

| File | Purpose |
|------|---------|
| [README.md](README.md) | Main project overview and quick start |
| [SAVE_SYSTEM_README.md](SAVE_SYSTEM_README.md) | Complete system documentation |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | API reference and code examples |
| [SETUP_GUIDE.md](SETUP_GUIDE.md) | Step-by-step setup instructions |
| [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md) | Comprehensive testing plan |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Visual diagrams and system architecture |

## Scripts (8)

| Script | Function | Description |
|--------|----------|-------------|
| [scr_build_save_data](scripts/scr_build_save_data/scr_build_save_data.gml) | `scr_build_save_data()` | Gathers all game state into a DS map |
| [scr_save_game](scripts/scr_save_game/scr_save_game.gml) | `scr_save_game(slot)` | Saves game data to disk as JSON |
| [scr_load_game](scripts/scr_load_game/scr_load_game.gml) | `scr_load_game(slot)` | Loads game data from disk |
| [scr_restore_instances](scripts/scr_restore_instances/scr_restore_instances.gml) | `scr_restore_instances()` | Recreates saved instances in room |
| [scr_destroy_save_data](scripts/scr_destroy_save_data/scr_destroy_save_data.gml) | `scr_destroy_save_data(map)` | Cleans up DS structures |
| [scr_save_exists](scripts/scr_save_exists/scr_save_exists.gml) | `scr_save_exists(slot)` | Checks if save file exists |
| [scr_debug_save_system](scripts/scr_debug_save_system/scr_debug_save_system.gml) | Multiple debug functions | Debug utilities for testing |
| [enum_menu_state](scripts/enum_menu_state/enum_menu_state.gml) | `enum_menu_state` | Menu state enumeration |

## Objects (4)

### obj_game_manager
**Purpose**: Persistent game state manager  
**Persistent**: Yes

| Event | File | Purpose |
|-------|------|---------|
| Create | [Create_0.gml](objects/obj_game_manager/Create_0.gml) | Initialize global variables |
| Step | [Step_0.gml](objects/obj_game_manager/Step_0.gml) | Handle pause menu toggle |
| Room Start | [Other_4.gml](objects/obj_game_manager/Other_4.gml) | Restore instances on room change |

### obj_menu_controller
**Purpose**: Pause menu with save/sound/exit options  
**Persistent**: No

| Event | File | Purpose |
|-------|------|---------|
| Create | [Create_0.gml](objects/obj_menu_controller/Create_0.gml) | Initialize menu state, pause game |
| Step | [Step_0.gml](objects/obj_menu_controller/Step_0.gml) | Handle input and menu logic |
| Draw GUI | [Draw_64.gml](objects/obj_menu_controller/Draw_64.gml) | Render menu interface |
| Destroy | [Destroy_0.gml](objects/obj_menu_controller/Destroy_0.gml) | Resume game |

### obj_saveable
**Purpose**: Base parent for all saveable objects  
**Parent**: None

| Event | File | Purpose |
|-------|------|---------|
| Create | [Create_0.gml](objects/obj_saveable/Create_0.gml) | Base initialization |
| User Event 6 | [Other_16.gml](objects/obj_saveable/Other_16.gml) | Save custom variables |
| User Event 7 | [Other_17.gml](objects/obj_saveable/Other_17.gml) | Load custom variables |

### obj_enemy_example
**Purpose**: Example implementation of saveable object  
**Parent**: obj_saveable

| Event | File | Purpose |
|-------|------|---------|
| Create | [Create_0.gml](objects/obj_enemy_example/Create_0.gml) | Initialize enemy properties |
| User Event 6 | [Other_16.gml](objects/obj_enemy_example/Other_16.gml) | Save enemy data |
| User Event 7 | [Other_17.gml](objects/obj_enemy_example/Other_17.gml) | Load enemy data |

## Total Files

- **Documentation**: 6 files
- **Scripts**: 8 files (8 GML files)
- **Objects**: 4 objects (13 GML event files)
- **Total**: 27 files

## Key Features by File

### Save/Load Core
- `scr_build_save_data` - Data collection
- `scr_save_game` - Disk writing
- `scr_load_game` - Disk reading
- `scr_restore_instances` - Instance recreation
- `scr_destroy_save_data` - Memory cleanup

### Menu System
- `obj_menu_controller` - UI and input
- `enum_menu_state` - State management

### Game Management
- `obj_game_manager` - Global state and coordination

### Extension System
- `obj_saveable` - Base class for custom objects
- `obj_enemy_example` - Implementation example

### Utilities
- `scr_save_exists` - Save file checking
- `scr_debug_save_system` - Debug tools

## File Size Breakdown

| Category | Lines of Code (approx) |
|----------|------------------------|
| Save/Load Scripts | ~350 lines |
| Menu Controller | ~180 lines |
| Game Manager | ~40 lines |
| Base Objects | ~60 lines |
| Example Implementation | ~40 lines |
| Documentation | ~1,800 lines |
| **Total** | **~2,470 lines** |

## Import Order

When importing into GameMaker Studio 2:

1. **Scripts First**
   - enum_menu_state
   - scr_build_save_data
   - scr_save_game
   - scr_load_game
   - scr_restore_instances
   - scr_destroy_save_data
   - scr_save_exists
   - scr_debug_save_system

2. **Objects Second**
   - obj_saveable (no dependencies)
   - obj_game_manager (depends on scripts)
   - obj_menu_controller (depends on scripts)
   - obj_enemy_example (depends on obj_saveable)

## Dependencies

```
obj_game_manager
    ├── scr_save_game
    ├── scr_load_game
    ├── scr_restore_instances
    └── obj_menu_controller
            ├── scr_save_game
            ├── enum_menu_state
            └── audio_master_gain (built-in)

scr_save_game
    ├── scr_build_save_data
    └── scr_destroy_save_data

scr_load_game
    └── scr_restore_instances

scr_build_save_data
    └── obj_saveable (User Event 6)

scr_restore_instances
    └── obj_saveable (User Event 7)
```

## Related Resources

### GameMaker Manual References
- `json_encode()` - JSON encoding for DS structures
- `json_decode()` - JSON decoding to DS structures
- `buffer_save()` - Writing buffers to disk
- `buffer_load()` - Reading buffers from disk
- `instance_create_depth()` - Creating instances
- `event_user()` - Triggering user events
- `audio_master_gain()` - Volume control

### Forum References
Implementations based on GameMaker Forum best practices for:
- Save/load systems
- Pause menus
- Instance serialization
- Memory management

## Navigation Guide

**Start Here**: [README.md](README.md)

**For Implementation**: [SETUP_GUIDE.md](SETUP_GUIDE.md)

**For Reference**: [QUICK_REFERENCE.md](QUICK_REFERENCE.md)

**For Understanding**: [ARCHITECTURE.md](ARCHITECTURE.md)

**For Testing**: [TESTING_CHECKLIST.md](TESTING_CHECKLIST.md)

**For Details**: [SAVE_SYSTEM_README.md](SAVE_SYSTEM_README.md)
