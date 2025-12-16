/// @description Checks if a save file exists
/// @param {Real} slot Save slot number (0-2)
/// @return {Bool} True if save exists, false otherwise
function scr_save_exists(_slot = 0) {
	var filename = working_directory + "saves/save" + string(_slot) + ".sav";
	return file_exists(filename);
}
