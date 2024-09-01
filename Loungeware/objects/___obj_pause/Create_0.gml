deactivated_instances = [];
paused_sounds = [];
microgame_current_metadata = ___MG_MNGR.microgame_current_metadata;
jam_id = noone;
input_cooldown = 0;
input_cooldown_init_max = 14;
input_cooldown_max = 10;
input_is_scrolling = false;
last_v_move = 0;

vol_step = 0.1;
arrow_xoff = 10;

OPTION = 0;
SLIDER = 1;


function menu_jam(){
	
	var _p = ___obj_pause;
	
	if (_p.jam_id == noone){
			_p.jam_id = audio_play_sound(___snd_henry_jazz, 0, true);
			audio_sound_gain(_p.jam_id, VOL_MASTER * VOL_MSC * audio_sound_get_gain(___snd_henry_jazz), 0);
			name = "JAMN'T";
	}  else if (_p.jam_id != noone && audio_is_paused(_p.jam_id)){
			audio_resume_sound(_p.jam_id); 
			name = "JAMN'T";
	} else {
		audio_pause_sound(_p.jam_id);
		name = "JAM";
	}
		
}

function menu_exit(){
	
	if (HTML_MODE) { // remove this code after LTS fixes cleanup not being called
		for (var i = 0; i < array_length(deactivated_instances); i++){
			var _id = deactivated_instances[i];
			instance_activate_object(_id);
			instance_destroy(_id, false);
		}
	}
	
	if (___obj_pause.gallery_mode){
		instance_create_layer(0, 0, ___obj_pause.layer, ___obj_menu_gallery);
	} else {
		with (instance_create_layer(0, 0, ___obj_pause.layer, ___obj_main_menu)) skip_intro = true;
	}
	workspace_end(); 
	application_surface_draw_enable(true);
	room_goto(___rm_main_menu); 
	instance_destroy(___obj_pause);
}

master_vol_down = method(self, function() {
	var res = ___global.save_data.vol.master - vol_step;
	
	___global.save_data.vol.master = max(0, res);

	if (___global.save_data.vol.master == res) {
		confirm_shake_timer = confirm_shake_timer_max * 0.4;
		___sound_menu_tick_horizontal();
	} else {
		confirm_shake_timer = confirm_shake_timer_max * 0.2;
		___sound_menu_bumper(2);
	}

	audio_sound_gain(jam_id, res, 0);
});

master_vol_up = method(self, function() {
	var res = ___global.save_data.vol.master + vol_step;
	
	___global.save_data.vol.master = min(1, res);
	
	if (___global.save_data.vol.master == res){
		confirm_shake_timer = confirm_shake_timer_max * 0.4;
		___sound_menu_tick_horizontal();
	} else {
		confirm_shake_timer = confirm_shake_timer_max * 0.2;
		___sound_menu_bumper(2);
	}
	
	audio_sound_gain(jam_id, res, 0);
});

difficulty_down = method(self, function() {
	var res = ___global.difficulty_level - 1;
	
	___global.difficulty_level = max(1, res);

	if (___global.difficulty_level == res){
		confirm_shake_timer = confirm_shake_timer_max * 0.4;
		___sound_menu_tick_horizontal();
	} else {
		confirm_shake_timer = confirm_shake_timer_max * 0.2;
		___sound_menu_bumper(2);
	}
});

difficulty_up = method(self, function() {
	var res = ___global.difficulty_level + 1;
	
	___global.difficulty_level = min(___global.difficulty_max, res);

	if (___global.difficulty_level == res){
		confirm_shake_timer = confirm_shake_timer_max * 0.4;
		___sound_menu_tick_horizontal();
	} else {
		confirm_shake_timer = confirm_shake_timer_max * 0.2;
		___sound_menu_bumper(2);
	}
});

menu = [
	{menu_type: OPTION, name:"RESUME", execute: method(self, function(){___obj_pause.state = "end";})},
	{menu_type: OPTION, name:"JAM", execute: method(self, menu_jam)},
	{menu_type: SLIDER, name:"VOL", left: master_vol_down, right: master_vol_up, value: method(self, function(){ return string(round(VOL_MASTER * 100)) + "%" })},
	{menu_type: OPTION, name:"EXIT", execute: method(self, menu_exit)},

]

cursor = 0;

state = "wait";

elip_frame = 0;

larold_frame = irandom(sprite_get_number(___spr_larold_heads)-1);
larold_changed = true;
used_frames = ds_list_create();

function populate_frame_list(){
	ds_list_clear(used_frames);
	for (var i = 0; i < sprite_get_number(___spr_larold_heads); i++) ds_list_add(used_frames, i);
	ds_list_shuffle(used_frames);
}

populate_frame_list();

surf_circle = noone;
col_circle = make_color_rgb(43, 35, 45);
circle_dir = 0;
sprite_dir = 90;
step = 0;
confirm_shake_timer = 0;
confirm_shake_timer_max = 15;

gallery_init = true;

tempo = 182;
beat_interval = 60/tempo;
beat_count = 0;
beat_count_prev = 0;
beats = 1;
beated = 0;
beat_alt = false;
linedir = 0;
double_alt = 1;
beat_prog = 0;
larold_credits = ___larold_get_credits();



//aaa = ds_map_create();
//bbb = ds_priority_create();
//for (var i = 0; i < array_length(larold_credits); i++){
//	var _name = larold_credits[i];
//	if (is_undefined(ds_map_find_value(aaa, _name))){
//		aaa[? _name] = 1;
//	} else{
//		aaa[? _name] += 1;
//	}
//}

//var key = ds_map_find_first(aaa);
//for (var i = 0; i < ds_map_size(aaa); i++){
//	var _val = aaa[? key];
//	ds_priority_add(bbb, key, _val);
//	key = ds_map_find_next(aaa, key);
//}

//var _str = "";
//var inc = 1;
//while (ds_priority_size(bbb) > 0){
//	var _name = ds_priority_delete_max(bbb);
//	var _count = aaa[? _name];
//	var _percent = ((_count / array_length(larold_credits)) * 100);
//	_str += string(inc) + ". " + _name + " | count: " + string( _count) + " | percent: " + string(_percent) + "%\n";
//	inc += 1;
//}

//show_message(_str);
