# System Architecture

Visual representation of how the save/load system and pause menu work together.

## Object Hierarchy

```
obj_game_manager (persistent)
    - Initializes global variables
    - Handles ESC key for pause menu
    - Calls scr_restore_instances on room start

obj_menu_controller
    - Created when ESC pressed
    - Pauses game via instance_deactivate_all
    - Provides UI for save/load/settings
    - Destroyed when menu closes

obj_saveable (parent)
    - Base class for all saveable objects
    - Defines User Event 6 (save)
    - Defines User Event 7 (load)
    |
    ├── obj_player
    ├── obj_enemy
    ├── obj_item
    └── [your gameplay objects]
```

## Save Flow

```
Player presses "Save Game" in menu
         ↓
scr_save_game(slot) called
         ↓
scr_build_save_data() creates DS map
         ↓
   ┌─────────────────────────────────┐
   │  DS Map (Root)                  │
   │  ├── "player_health": 100       │
   │  ├── "player_score": 500        │
   │  ├── "volume": 0.8              │
   │  └── "instances": DS List ───┐  │
   └──────────────────────────────│──┘
                                  ↓
                  ┌───────────────────────────────┐
                  │  DS List (Instances)          │
                  │  ├── Instance 0: DS Map       │
                  │  │   ├── "object_name": "..."  │
                  │  │   ├── "x": 100              │
                  │  │   ├── "y": 200              │
                  │  │   └── "extra_data": DS Map  │
                  │  │       └── [custom vars]     │
                  │  ├── Instance 1: DS Map        │
                  │  └── Instance 2: DS Map        │
                  └───────────────────────────────┘
         ↓
json_encode() converts to JSON string
         ↓
buffer_save() writes to file
         ↓
"working_directory/saves/save0.sav"
         ↓
scr_destroy_save_data() cleans up
         ↓
"Game Saved!" message shown
```

## Load Flow

```
scr_load_game(slot) called
         ↓
Check if file exists
         ↓
buffer_load() reads file
         ↓
json_decode() parses JSON to DS map
         ↓
Extract global variables
  - global.player_health = save_map[? "health"]
  - global.volume = save_map[? "volume"]
  - etc.
         ↓
Store instance list in global.instances_to_restore
         ↓
room_goto(saved_room)
         ↓
Room Start Event fires
         ↓
scr_restore_instances() called
         ↓
   ┌───────────────────────────────┐
   │  For each instance in list:   │
   │  1. Get object name           │
   │  2. Convert to object_index   │
   │  3. instance_create_depth()   │
   │  4. Set position/properties   │
   │  5. Call User Event 7 (load)  │
   │  6. Instance restores vars    │
   └───────────────────────────────┘
         ↓
Clean up DS structures
         ↓
Game state fully restored!
```

## Pause Menu State Machine

```
                    ┌──────────────────┐
                    │   No Menu Active │
                    │  (game running)  │
                    └─────────┬────────┘
                              │
                         ESC pressed
                              ↓
                    ┌──────────────────┐
                    │  MAIN MENU       │
                    │  - Resume        │
                    │  - Save Game     │
                    │  - Sound Settings│
                    │  - Exit Game     │
                    └─────┬─────┬──────┘
                          │     │
            "Sound Settings"    "Resume"
                    │           │
                    ↓           ↓
          ┌────────────────┐   Destroy menu
          │  SOUND MENU    │   (game resumes)
          │  - Volume: XX% │
          │  - Back        │
          └────┬───────────┘
               │
          "Back" or ESC
               │
               ↓
          Return to MAIN
```

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        GAME STATE                           │
│                                                              │
│  Global Variables          Instances                        │
│  ├── health                ├── obj_player                   │
│  ├── score                 ├── obj_enemy (x3)               │
│  ├── level                 ├── obj_item (x5)                │
│  └── volume                └── obj_npc (x2)                 │
│                                                              │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ SAVE
                   ↓
        ┌──────────────────────┐
        │   scr_build_save_data│
        │   - Gather globals   │
        │   - Loop instances   │
        │   - Trigger Event 6  │
        └──────────┬───────────┘
                   │
                   ↓
        ┌──────────────────────┐
        │      DS Map          │
        │   (in memory)        │
        └──────────┬───────────┘
                   │
                   │ json_encode
                   ↓
        ┌──────────────────────┐
        │    JSON String       │
        │   (in memory)        │
        └──────────┬───────────┘
                   │
                   │ buffer_save
                   ↓
        ┌──────────────────────┐
        │   save0.sav          │
        │   (on disk)          │
        └──────────┬───────────┘
                   │
                   │ LOAD
                   │ buffer_load
                   ↓
        ┌──────────────────────┐
        │    JSON String       │
        │   (in memory)        │
        └──────────┬───────────┘
                   │
                   │ json_decode
                   ↓
        ┌──────────────────────┐
        │      DS Map          │
        │   (in memory)        │
        └──────────┬───────────┘
                   │
                   ↓
        ┌──────────────────────┐
        │  scr_restore_instances│
        │  - Set globals       │
        │  - Create instances  │
        │  - Trigger Event 7   │
        └──────────┬───────────┘
                   │
                   ↓
┌──────────────────────────────────────────────────────────────┐
│                    RESTORED GAME STATE                       │
│                                                               │
│  Global Variables          Instances                         │
│  ├── health (restored)     ├── obj_player (recreated)        │
│  ├── score (restored)      ├── obj_enemy x3 (recreated)      │
│  ├── level (restored)      ├── obj_item x5 (recreated)       │
│  └── volume (restored)     └── obj_npc x2 (recreated)        │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

## User Event Flow

### User Event 6 (Save)

```
scr_build_save_data loops through instances
         ↓
For each instance that inherits from obj_saveable:
         ↓
Create empty extra_data map
         ↓
Set other.extra_data = empty map
         ↓
Call event_user(6) on instance
         ↓
Instance's User Event 6 code executes:
    other.extra_data[? "my_var"] = my_var;
    other.extra_data[? "health"] = health;
         ↓
extra_data now contains instance's custom variables
         ↓
Add extra_data to instance's save entry
         ↓
Continue to next instance
```

### User Event 7 (Load)

```
scr_restore_instances loops through saved instances
         ↓
For each saved instance:
         ↓
Create new instance at saved position
         ↓
Set other.loaded_extra_data = saved extra_data map
         ↓
Call event_user(7) on new instance
         ↓
Instance's User Event 7 code executes:
    my_var = other.loaded_extra_data[? "my_var"];
    health = other.loaded_extra_data[? "health"];
         ↓
Instance's custom variables restored
         ↓
Continue to next instance
```

## Memory Management

```
┌────────────────────────────────────────────────────┐
│              Memory Lifecycle                      │
├────────────────────────────────────────────────────┤
│                                                    │
│  SAVE:                                             │
│  1. ds_map_create()      ← Root map               │
│  2. ds_list_create()     ← Instance list           │
│  3. ds_map_create() x N  ← Instance data maps      │
│  4. ds_map_create() x N  ← Extra data maps         │
│                                                    │
│  ... data written to file ...                      │
│                                                    │
│  5. ds_map_destroy()     ← Extra data maps         │
│  6. ds_map_destroy()     ← Instance data maps      │
│  7. ds_list_destroy()    ← Instance list           │
│  8. ds_map_destroy()     ← Root map                │
│                                                    │
│  ✓ All memory freed!                               │
│                                                    │
│  LOAD:                                             │
│  1. json_decode()        ← Creates DS structures   │
│  2. Extract data                                   │
│  3. Instances created                              │
│  4. ds_map_destroy()     ← Extra data maps         │
│  5. ds_map_destroy()     ← Instance data maps      │
│  6. ds_list_destroy()    ← Instance list           │
│  7. ds_map_destroy()     ← Root map                │
│                                                    │
│  ✓ All memory freed!                               │
│                                                    │
└────────────────────────────────────────────────────┘
```

## Error Handling Flow

```
scr_save_game() / scr_load_game()
         ↓
    try {
         ↓
    Operation (save/load)
         ↓
    Success? ──Yes──→ Return true
         │
         No
         ↓
    } catch (e) {
         ↓
    Log error to debug console
         ↓
    Clean up any partial data
         ↓
    Return false
```

## File Structure

```
working_directory/
└── saves/
    ├── save0.sav    ← Slot 0
    ├── save1.sav    ← Slot 1
    └── save2.sav    ← Slot 2

Each .sav file contains:
{
    "player_health": 100,
    "player_score": 500,
    "volume": 0.8,
    "current_room": "rm_level1",
    "instances": [
        {
            "object_name": "obj_player",
            "x": 320,
            "y": 240,
            "extra_data": {
                "ammo": 50,
                "equipped_weapon": 2
            }
        },
        // ... more instances
    ]
}
```

## Component Dependencies

```
                obj_game_manager
                      │
                      ├──► scr_save_game
                      │         │
                      │         └──► scr_build_save_data
                      │                   │
                      │                   └──► obj_saveable (User Event 6)
                      │
                      ├──► scr_load_game
                      │         │
                      │         └──► scr_restore_instances
                      │                   │
                      │                   └──► obj_saveable (User Event 7)
                      │
                      └──► obj_menu_controller
                                  │
                                  ├──► scr_save_game
                                  └──► audio_master_gain
```

This architecture ensures clean separation of concerns, proper memory management, and extensible design for future features.
