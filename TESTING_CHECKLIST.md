# Testing Checklist

## Pre-Test Setup
- [ ] `obj_game_manager` placed in first room
- [ ] All gameplay objects inherit from `obj_saveable`
- [ ] User Events 6 & 7 implemented for custom variables
- [ ] Global variables initialized in game manager

## Save System Tests

### Basic Save/Load
- [ ] Press ESC to open pause menu
- [ ] Select "Save Game"
- [ ] See "Game Saved!" message
- [ ] Check `working_directory/saves/save0.sav` exists
- [ ] Modify game state (move player, change variables)
- [ ] Exit and restart game
- [ ] Call `scr_load_game(0)` from debug console
- [ ] Verify game state restored correctly

### Instance Persistence
- [ ] Create saveable objects in room
- [ ] Move/modify them
- [ ] Save game
- [ ] Delete/modify instances
- [ ] Load game
- [ ] Verify original instances restored at correct positions
- [ ] Verify custom variables restored correctly

### Multiple Save Slots
- [ ] Save to slot 0
- [ ] Modify game state
- [ ] Save to slot 1
- [ ] Load slot 0
- [ ] Verify slot 0 state restored
- [ ] Load slot 1
- [ ] Verify slot 1 state restored

### Edge Cases
- [ ] Load from empty slot (should fail gracefully)
- [ ] Save with no instances (should work)
- [ ] Save and load with empty global variables
- [ ] Delete save file manually, then try to load
- [ ] Save with very long variable names/values

## Pause Menu Tests

### Menu Navigation
- [ ] Press ESC to open menu
- [ ] Menu appears with semi-transparent overlay
- [ ] Use ↑/↓ to navigate
- [ ] Selection highlights correctly
- [ ] All 4 options visible (Resume, Save, Sound, Exit)

### Menu Options
- [ ] **Resume**: Closes menu, returns to game
- [ ] **Save Game**: Shows "Game Saved!" message
- [ ] **Sound Settings**: Opens sound submenu
- [ ] **Exit Game**: Closes application

### Pause Functionality
- [ ] Game freezes when menu is open
- [ ] Player can't move
- [ ] Enemies don't move
- [ ] Physics don't update
- [ ] Game resumes when menu closes

## Sound Settings Tests

### Volume Control
- [ ] Open Sound Settings submenu
- [ ] Volume shows current percentage
- [ ] Press ← to decrease volume
- [ ] Press → to increase volume
- [ ] Hear volume change immediately
- [ ] Volume can't go below 0%
- [ ] Volume can't go above 100%

### Sound Persistence
- [ ] Set volume to 50%
- [ ] Save game
- [ ] Close game
- [ ] Restart and load save
- [ ] Verify volume is still 50%

### Navigation
- [ ] ESC returns to main menu
- [ ] Select "Back" returns to main menu
- [ ] Selection state resets when returning

## Debug Functions

Run these in the debug console:

### Print Save Data
```gml
scr_debug_print_save(0);
```
- [ ] Outputs readable JSON
- [ ] Shows all global variables
- [ ] Shows instance data
- [ ] No errors in console

### List All Saves
```gml
scr_debug_list_saves();
```
- [ ] Shows all 3 slots
- [ ] Correctly identifies empty/full slots

### Delete Save
```gml
scr_debug_delete_save(0);
```
- [ ] Removes save file
- [ ] Confirms deletion in console
- [ ] scr_save_exists(0) returns false

### Test Save/Load Cycle
```gml
scr_debug_test_save_load();
```
- [ ] Saves successfully
- [ ] Modifies variables
- [ ] Loads successfully
- [ ] Restores original values
- [ ] No errors in console

## Memory Leak Tests

### DS Structure Cleanup
- [ ] Save game 100 times in a loop
- [ ] Check memory usage (shouldn't increase significantly)
- [ ] Load game 100 times in a loop
- [ ] Check memory usage (shouldn't increase significantly)

### Menu Open/Close
- [ ] Open and close pause menu 50 times
- [ ] Check memory usage
- [ ] No crashes or slowdown

## Integration Tests

### Room Transitions
- [ ] Save in room A
- [ ] Move to room B
- [ ] Load save
- [ ] Verify player returns to room A
- [ ] Verify room A instances restored

### Complex Scenarios
- [ ] Player at low health
- [ ] Multiple enemies with different states
- [ ] Items collected
- [ ] Save game
- [ ] Modify everything
- [ ] Load game
- [ ] Verify everything matches saved state

## Performance Tests

### Large Save Files
- [ ] Create 100+ saveable instances
- [ ] Save game
- [ ] Measure save time (should be < 1 second)
- [ ] Load game
- [ ] Measure load time (should be < 2 seconds)

### Rapid Save/Load
- [ ] Save and load repeatedly
- [ ] No lag spikes
- [ ] No frame drops
- [ ] Console shows no errors

## Error Handling Tests

### Corrupt Save File
- [ ] Manually edit save file with invalid JSON
- [ ] Try to load
- [ ] Game doesn't crash
- [ ] Error logged to console

### Missing Save File
- [ ] Delete save file
- [ ] Try to load
- [ ] Returns false gracefully
- [ ] No crash

### Missing Object Definition
- [ ] Save game with object A
- [ ] Delete object A from project
- [ ] Try to load
- [ ] Warning logged for missing object
- [ ] Other instances still load

## User Experience Tests

### Visual Feedback
- [ ] Menu items clearly visible
- [ ] Selection highlight obvious
- [ ] Text readable against background
- [ ] Save confirmation visible for 1.5 seconds

### Controls Feel Good
- [ ] Menu navigation responsive
- [ ] No accidental selections
- [ ] Volume adjustment smooth
- [ ] ESC consistently opens/closes menu

## Final Checks
- [ ] No memory leaks detected
- [ ] No crashes during testing
- [ ] All debug messages appropriate
- [ ] Save files human-readable (JSON)
- [ ] Documentation matches implementation

## Notes Section
Record any issues found:
- 
- 
- 

## Sign-Off
- Date Tested: __________
- Tested By: __________
- Result: PASS / FAIL / NEEDS WORK
