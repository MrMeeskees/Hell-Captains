/// @description Restores instances from loaded save data
/// @description Called in room start after loading a save
function scr_restore_instances() {
	if (!variable_global_exists("instances_to_restore")) {
		return;
	}
	
	var obj_list = global.instances_to_restore;
	if (obj_list == undefined || !ds_exists(obj_list, ds_type_list)) {
		return;
	}
	
	// Destroy existing non-persistent gameplay objects
	with (all) {
		if (!persistent && object_is_ancestor(object_index, obj_saveable)) {
			instance_destroy();
		}
	}
	
	// Recreate saved instances
	for (var i = 0; i < ds_list_size(obj_list); i++) {
		var inst_data = obj_list[| i];
		
		if (!ds_exists(inst_data, ds_type_map)) {
			continue;
		}
		
		// Get object index from name
		var obj_name = inst_data[? "object_name"];
		var obj_index = asset_get_index(obj_name);
		
		if (obj_index == -1) {
			show_debug_message("Warning: Could not find object: " + obj_name);
			continue;
		}
		
		// Create instance
		var inst = instance_create_depth(
			inst_data[? "x"],
			inst_data[? "y"],
			0,
			obj_index
		);
		
		// Restore basic properties
		inst.image_xscale = inst_data[? "image_xscale"];
		inst.image_yscale = inst_data[? "image_yscale"];
		inst.image_angle = inst_data[? "image_angle"];
		
		// Restore extra data via User Event 7
		with (inst) {
			other.loaded_extra_data = inst_data[? "extra_data"];
			event_user(7);
		}
	}
	
	// Clean up
	scr_destroy_save_data_instances(obj_list);
	global.instances_to_restore = undefined;
}
