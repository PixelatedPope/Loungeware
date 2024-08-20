// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("wae_HogginAHog", {
    config_version: 1,
    game_name: "Hoggin' a Hog",
    authors : "Waesome",
    prompt: "STEAL THE PIG!",
    init_room: wae_hog_room,
    view_width: 240,
    view_height: 160,
    time_seconds: 9,
    music_track: sng_zandy_woohoo_kong, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [54, 43, 43],
    cartridge_col_secondary: [220, 55, 225],
    cartridge_label: wae_hog_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Waesome"],
    date_added:{
	  day : 21,
	  month : 6,
	  year : 2024
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Steer an unwieldy hog to freedom!", 
	],
	how_to_play: [
		"Stabilize the hog so it faces the exit. Use left and right to affect the hog's rotation."
	],
});

microgame_register("wae_MissileDefense", {
    config_version: 1,
    game_name: "Missile Defense",
    authors : "Waesome",
    prompt: "DESTROY MISSILES!",
    init_room: wae_missle_room,
    view_width: 240,
    view_height: 160,
    time_seconds: 9,
    music_track: wae_sng_missle2, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
	cartridge_col_primary: [67, 100, 204],
    cartridge_col_secondary: [153, 148, 255],
    cartridge_label: wae_missle_label,
    default_is_fail: false, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Waesome"],
    date_added:{
	  day : 18,
	  month : 8,
	  year : 2024
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Destroy missiles headed to Larold's Crystal!", 
	],
	how_to_play: [
		"Angle the flak cannon with arrow keys and fire with either A or B. Destroy all missiles to win!"
	],
});
