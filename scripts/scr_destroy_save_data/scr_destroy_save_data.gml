/// @description Destroys save data DS structures to prevent memory leaks
/// @param {Id.DsMap} save_map The save map to destroy
function scr_destroy_save_data(_save_map) {
	if (!ds_exists(_save_map, ds_type_map)) {
		return;
	}
	
	// Destroy instance list and nested maps
	var obj_list = _save_map[? "instances"];
	scr_destroy_save_data_instances(obj_list);
	
	// Destroy root map
	ds_map_destroy(_save_map);
}

/// @description Destroys the instances list from save data
/// @param {Id.DsList} obj_list The instances list to destroy
function scr_destroy_save_data_instances(_obj_list) {
	if (!ds_exists(_obj_list, ds_type_list)) {
		return;
	}
	
	for (var i = 0; i < ds_list_size(_obj_list); i++) {
		var inst_data = _obj_list[| i];
		
		if (ds_exists(inst_data, ds_type_map)) {
			// Destroy extra_data map if it exists
			var extra_data = inst_data[? "extra_data"];
			if (ds_exists(extra_data, ds_type_map)) {
				ds_map_destroy(extra_data);
			}
			
			ds_map_destroy(inst_data);
		}
	}
	
	ds_list_destroy(_obj_list);
}
