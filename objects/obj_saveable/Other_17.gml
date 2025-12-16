/// obj_saveable - User Event 7 (Load)
/// Override this in child objects to load custom variables

// Example implementation for child objects:
// if (ds_map_exists(other.loaded_extra_data, "my_variable")) {
//     my_variable = other.loaded_extra_data[? "my_variable"];
//     health = other.loaded_extra_data[? "my_health"];
// }
