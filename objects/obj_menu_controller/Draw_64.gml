/// obj_menu_controller - Draw GUI Event
/// Draws the pause menu

// Draw semi-transparent background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Draw title
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1); // Use default font

var title_text = "";
var menu_items = [];
var menu_count = 0;

switch (menu_state) {
	case enum_menu_state.MAIN:
		title_text = "PAUSED";
		menu_items = main_menu_items;
		menu_count = main_menu_count;
		break;
		
	case enum_menu_state.SOUND:
		title_text = "SOUND SETTINGS";
		menu_items = sound_menu_items;
		menu_count = sound_menu_count;
		break;
}

draw_text(menu_x, menu_y - 80, title_text);

// Draw menu items
for (var i = 0; i < menu_count; i++) {
	var item_y = menu_y + (i * menu_item_height);
	
	// Draw selection highlight
	if (i == selected_item) {
		draw_set_color(c_yellow);
		draw_rectangle(
			menu_x - 150,
			item_y - 15,
			menu_x + 150,
			item_y + 15,
			false
		);
		draw_set_color(c_black);
		draw_text(menu_x, item_y, menu_items[i]);
	} else {
		draw_set_color(c_white);
		draw_text(menu_x, item_y, menu_items[i]);
	}
}

// Draw hint text for sound menu
if (menu_state == enum_menu_state.SOUND && selected_item == 0) {
	draw_set_color(c_gray);
	draw_text(menu_x, menu_y + (menu_count * menu_item_height) + 30, "Use Left/Right arrows to adjust");
}

// Draw message if active
if (message_timer > 0) {
	draw_set_color(c_lime);
	draw_text(menu_x, menu_y + (menu_count * menu_item_height) + 60, message);
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
