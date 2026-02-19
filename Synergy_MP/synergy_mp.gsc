#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\perks;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_shared;

#namespace synergy;

autoexec __init__system__() { //89f2df9
	precache("eventstring", #"synergy_menu");
	precache("eventstring", #"synergy_element_1");
	precache("eventstring", #"synergy_element_2");
	precache("eventstring", #"synergy_element_3");
	precache("eventstring", #"synergy_element_4");
	precache("eventstring", #"synergy_element_5");
	precache("eventstring", #"synergy_element_6");

	precache("eventstring", #"synergy_toggle_1");
	precache("eventstring", #"synergy_toggle_2");
	precache("eventstring", #"synergy_toggle_3");
	precache("eventstring", #"synergy_toggle_4");
	precache("eventstring", #"synergy_toggle_5");
	precache("eventstring", #"synergy_toggle_6");
	precache("eventstring", #"synergy_toggle_7");

	precache("eventstring", #"synergy_slider_1");
	precache("eventstring", #"synergy_slider_2");
	precache("eventstring", #"synergy_slider_3");
	precache("eventstring", #"synergy_slider_4");
	precache("eventstring", #"synergy_slider_5");
	precache("eventstring", #"synergy_slider_6");
	precache("eventstring", #"synergy_slider_7");

	precache("eventstring", #"synergy_title");
	precache("eventstring", #"synergy_description");

	precache("eventstring", #"synergy_option_1");
	precache("eventstring", #"synergy_option_2");
	precache("eventstring", #"synergy_option_3");
	precache("eventstring", #"synergy_option_4");
	precache("eventstring", #"synergy_option_5");
	precache("eventstring", #"synergy_option_6");
	precache("eventstring", #"synergy_option_7");

	precache("eventstring", #"synergy_slider_text_1");
	precache("eventstring", #"synergy_slider_text_2");
	precache("eventstring", #"synergy_slider_text_3");
	precache("eventstring", #"synergy_slider_text_4");
	precache("eventstring", #"synergy_slider_text_5");
	precache("eventstring", #"synergy_slider_text_6");
	precache("eventstring", #"synergy_slider_text_7");

	precache("eventstring", #"synergy_submenu_icon_1");
	precache("eventstring", #"synergy_submenu_icon_2");
	precache("eventstring", #"synergy_submenu_icon_3");
	precache("eventstring", #"synergy_submenu_icon_4");
	precache("eventstring", #"synergy_submenu_icon_5");
	precache("eventstring", #"synergy_submenu_icon_6");
	precache("eventstring", #"synergy_submenu_icon_7");

	system::register("synergy", &init, undefined, undefined);
}

init() { //9284135d
	level.initialized = false;
	callback::on_spawned(&player_connect);
	level thread create_rainbow_color();
}

initial_variables() { //ec264b2e
	self.in_menu = false;
	self.initialized = false;
	self.hud_created = false;
	self.loaded_offset = false;
	self.option_limit = 7;
	self.current_menu = "Synergy";
	self.structure = array();
	self.previous = array();
	self.previous_option = undefined;
	self.saved_index = array();
	self.saved_offset = array();
	self.saved_trigger = array();
	self.slider = array();

	self.x_offset = 1220;
	self.y_offset = 400;

	self.rainbow_enabled = true;
	self.menu_color_red = 0;
	self.menu_color_green = 0;
	self.menu_color_blue = 0;

	self.syn["background"] = spawnStruct();
	self.syn["cursor"] = spawnStruct();
	self.syn["background"].height = 450;
	self.syn["cursor"].y = 430;
	self.syn["cursor"].index = 0;
	self.scrolling_offset = 0;
	self.previous_scrolling_offset = 0;
	self.description_height = 0;

	// Weapons

	self.syn["mastercraft"] = array();

	self.syn["weapons"]["category"][0] = ["assault_rifles", "sub_machine_guns", "tactical_rifles", "light_machine_guns", "sniper_rifles", "shotguns", "pistols", "launchers", "melee", "equipment", "extras", "specialist", "specialist_equipment"];
	self.syn["weapons"]["category"][1] = ["Assault Rifles", "Sub Machine Guns", "Tactical Rifles", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Melee", "Equipment", "Extras", "Specialist", "Specialist Equipment"];

	self.syn["weapons"]["assault_rifles"][0] =       array("ar_accurate_t8", "ar_fastfire_t8", "ar_modular_t8", "ar_damage_t8", "ar_stealth_t8", "ar_galil_t8", "ar_standard_t8", "ar_an94_t8", "ar_doublebarrel_t8", "ar_peacekeeper_t8");
	self.syn["weapons"]["sub_machine_guns"][0] =     array("smg_standard_t8", "smg_fastfire_t8", "smg_handling_t8", "smg_accurate_t8", "smg_capacity_t8", "smg_vmp_t8", "smg_fastburst_t8", "smg_folding_t8", "smg_minigun_t8");
	self.syn["weapons"]["tactical_rifles"][0] =      array("tr_longburst_t8", "tr_midburst_t8", "tr_powersemi_t8", "tr_flechette_t8", "tr_damageburst_t8");
	self.syn["weapons"]["light_machine_guns"][0] =   array("lmg_standard_t8", "lmg_spray_t8", "lmg_heavy_t8", "lmg_stealth_t8");
	self.syn["weapons"]["sniper_rifles"][0] =        array("sniper_powersemi_t8", "sniper_powerbolt_t8", "sniper_quickscope_t8", "sniper_fastrechamber_t8", "sniper_locus_t8", "sniper_mini14_t8", "sniper_damagesemi_t8");
	self.syn["weapons"]["shotguns"][0] =             array("shotgun_semiauto_t8", "shotgun_pump_t8", "shotgun_precision_t8", "shotgun_fullauto_t8");
	self.syn["weapons"]["pistols"][0] =              array("pistol_revolver_t8", "pistol_standard_t8", "pistol_burst_t8", "pistol_fullauto_t8");
	self.syn["weapons"]["launchers"][0] =            array("launcher_standard_t8", "special_crossbow_t8");
	self.syn["weapons"]["melee"][0] =                array("special_ballisticknife_t8_dw", "special_ballisticknife_t8_dw_dw", "melee_actionfigure_t8", "melee_slaybell_t8", "melee_secretsanta_t8", "melee_coinbag_t8", "melee_demohammer_t8", "melee_club_t8", "melee_cutlass_t8", "melee_zombiearm_t8", "melee_bowie_bloody", "melee_amuletfist_t8", "melee_stopsign_t8");
	self.syn["weapons"]["equipment"][0] =            array("hatchet", "frag_grenade", "eq_molotov", "eq_slow_grenade", "trophy_system", "eq_acid_bomb", "claymore", "eq_molotov", "proximity_grenade");
	self.syn["weapons"]["extras"][0] =               array("gun_ultimate_turret", "ultimate_turret", "molotov_fire", "mini_turret", "concussion_grenade", "ray_gun", "briefcase_bomb_defuse");
	self.syn["weapons"]["specialist"][0] =           array("sig_buckler_dw", "sig_buckler_turret", "hero_pineapplegun", "hero_pineapple_grenade", "hero_flamethrower", "ability_dog", "sig_bow_quickshot", "shock_rifle", "sig_lmg", "eq_gravityslam", "hero_annihilator", "sig_blade");
	self.syn["weapons"]["specialist_equipment"][0] = array("eq_swat_grenade", "eq_cluster_semtex_grenade", "gadget_supplypod", "gadget_radiation_field", "eq_tripwire", "eq_hawk", "eq_seeker_mine", "eq_shroud", "eq_sensor", "eq_grapple", "gadget_spawnbeacon", "eq_smoke", "eq_concertina_wire", "eq_emp_grenade");

	self.syn["weapons"]["assault_rifles"][1] =       array("ICR-7", "Maddox RFB", "KN-57", "Rampart 17", "VAPR-XKG", "Grav", "Swat RFT", "AN-94", "Doublecross", "Peacekeeper");
	self.syn["weapons"]["sub_machine_guns"][1] =     array("MX9", "Spitfire", "Saug 9mm", "GKS", "Cordite", "VMP", "Daemon 3XB", "Switchblade X9", "MicroMG 9mm");
	self.syn["weapons"]["tactical_rifles"][1] =      array("Swordfish", "ABR 223", "Auger DMR", "S6 Stingray", "M16");
	self.syn["weapons"]["light_machine_guns"][1] =   array("Titan", "Hades", "VKM 750", "Tigershark");
	self.syn["weapons"]["sniper_rifles"][1] =        array("SDM", "Paladin HB50", "Koshka", "Outlaw", "Locus", "Vendetta", "Havelina AA50");
	self.syn["weapons"]["shotguns"][1] =             array("SG12", "MOG 12", "Argus", "Rampage");
	self.syn["weapons"]["pistols"][1] =              array("Mozu", "Strife", "RK 7 Garrison", "KAP 45");
	self.syn["weapons"]["launchers"][1] =            array("Hellion Salvo", "Reaver C86");
	self.syn["weapons"]["melee"][1] =                array("Ballistic Knife", "Ballistic Knife (Double)", "Series 6 Outrider", "Slay Bell", "Secret Santa", "Cha-Ching", "Home Wrecker", "Nifo'oti", "Rising Tide", "Backhander", "Bowie Knife", "Eye of Apophis", "Full Stop");
	self.syn["weapons"]["equipment"][1] =            array("Combat Axe", "Frag Grenade", "Molotov", "Concussion", "Trophy System", "Acid Bomb", "Claymore", "Molotov", "Shock Charge");
	self.syn["weapons"]["extras"][1] =               array("Handheld Sentry Gun", "Sentry Gun", "Incendiary Grenade", "Mini Turret", "Concussion Grenade", "Ray Gun", "S&D Bomb");
	self.syn["weapons"]["specialist"][1] =           array("Ballistic Shield", "Ballistic Shield (Fortified)", "War Machine", "War Machine (Short Range)", "Purifier", "K9-Unit", "Sparrow", "Tempest", "Scythe", "Grav Slam", "Annihilator", "Shadow Blade");
	self.syn["weapons"]["specialist_equipment"][1] = array("9-Bang", "Cluster Grenade", "Assault Pack", "Reactor Core", "Mesh Mine", "Hawk", "Seeker", "Radar Shroud", "Sensor Dart", "Grapple Gun", "Tac-Deploy", "Smoke", "Razor Wire", "EMP Disruptor");

	// Attachments

	self.syn["attachments"][0] = array("acog", "damage", "damage2", "dualoptic", "dw", "elo", "extbarrel", "extbarrel2", "extclip", "extclip2", "fastreload", "fastreload2", "fmj", "fmj2", "grip", "grip2", "holo", "is", "ir", "mixclip", "mms", "pistolscope", "quickdraw", "quickdraw2", "reflex", "rf", "speedreloader", "stalker", "stalker2", "steadyaim", "steadyaim2", "suppressed", "swayreduc", "uber");
	self.syn["attachments"][1] = array("Acog", "High Caliber", "High Caliber II", "Dual Zoom", "Dual Wield", "Elo", "Long Barrel", "Long Barrel II", "Extended Mags", "Extended Mags II", "Fast Mags", "Fast Mags II", "FMJ", "FMJ II", "Grip", "Grip II", "Holographic", "Iron Sights", "Thermal", "Hybrid Mags", "Threat Detector", "Compact Scope", "Quickdraw", "Quickdraw II", "Reflex", "Rapid Fire", "Speed Loader", "Stock", "Stock II", "Laser Sight", "Laser Sight II", "Suppressor", "Stabilizer", "Operator Mod");

	// Killstreaks

	self.syn["killstreaks"][0] = array("dart", "recon_car", "uav", "supply_drop", "counteruav", "planemortar", "ultimate_turret", "remote_missile", "drone_squadron", "overwatch_helicopter", "tank_robot", "straferun", "helicopter_comlink", "swat_team", "ac130");
	self.syn["killstreaks"][1] = array("Dart", "RC-XD", "UAV", "Care Package", "Counter-UAV", "Lightning Strike", "Sentry", "Hellstorm", "Drone Squad", "Sniper's Nest", "Mantis", "Thresher", "Attack Chopper", "Strike Team", "Gunship");

	// Camos

	self.syn["camos"][0] = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 332, 198, 199, 45, 195, 194, 193, 192);
	self.syn["camos"][1] = array("Hunt", "Grassland", "Overgrowth", "Patrol", "Desert Fox", "Tundra", "Panther", "Coral Panther", "Rend", "Monsoon", "Radar", "Tropic", "Agitator", "Roll", "Roil", "URD", "Urban", "Mangrove", "Bengal", "Platoon", "Clash", "Massacre", "Frost", "Dune", "Red Tiger", "Blue Tiger", "Green Tiger", "Roller Rink", "Fast Times", "Gutter Ball", "Mother of Pearl", "Red Oyster", "Spore", "Purple Hex", "Stealth Hex", "Red Hex Redux", "Penthouse", "Yacht Club", "Emerald UG", "Spectrum", "Infiltrator", "Silverfish", "Gold", "Diamond", "Diamond Alt", "Purple Diamond", "Rainbow Diamond", "Dark Matter", "Dark Matter Orange", "Dark Matter Red", "Dark Matter Red Alt", "Classic Dark Matter");
	self.syn["camos"][2] = array(146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 280, 281, 282, 283, 284, 74, 75, 76, 77, 78, 345, 394);
	self.syn["camos"][3] = array("Voyage of Despair Blue", "Voyage of Despair Red", "Voyage of Despair Green", "Voyage of Despair Yellow", "Voyage of Despair Purple", "IX Blue", "IX Red", "IX Green", "IX Purple", "IX Yellow", "Blood of the Dead Yellow", "Blood of the Dead Red", "Blood of the Dead Purple", "Blood of the Dead Green", "Blood of the Dead Pink", "Classified White", "Classified Black", "Classified Blue", "Classified Green", "Classified Red", "Dead of the Night Green", "Dead of the Night Purple", "Dead of the Night Red", "Dead of the Night Blue", "Dead of the Night Yellow", "Ancient Evil Purple", "Ancient Evil Blue", "Ancient Evil Red", "Ancient Evil Yellow", "Ancient Evil Green", "Alpha Omega", "Tag Der Toten");
	self.syn["camos"][4] = array(129, 119, 346, 80, 86, 120, 117, 46, 81, 83, 79, 51, 314, 347, 355, 354, 348, 135, 387, 136, 121, 352, 349, 315, 49, 50, 122, 123, 317, 350, 351, 82, 316, 134, 353, 48, 84, 47, 88, 137, 118, 249, 124, 58, 59, 60, 61, 167, 184, 185, 91, 92, 131, 132, 133, 138, 89, 94, 95, 286, 287, 357, 391, 392, 393, 288, 289, 290, 295, 296, 297, 298, 53, 54, 55, 56, 306, 307, 305, 308, 172, 187, 188, 189, 191, 228, 310, 311, 312, 313, 68, 69, 70, 359, 360, 361, 385, 293, 170, 200, 300, 301, 302, 303, 363, 364, 365, 366, 168, 381, 382, 383, 384, 171, 181, 182, 126, 127, 389, 390, 166, 208, 209, 210, 211, 63, 64, 65, 66, 71, 72, 173, 201);
	self.syn["camos"][5] = array("115", "Afterglow", "America", "Armor", "Assassin", "Astronomy", "Bacon", "Bejamins", "Blowfish", "Board Shorts", "Burple", "Carbolicious", "Cherry Blossom", "Citrus", "Connected", "Datamine", "Dino Glyphs", "Fear Haze", "Fractal Flames", "Fractalized", "Goosebumps", "Green Gradient", "Jellymaw", "Killabyte", "Kiss of Death", "Lady Luck", "Paradise", "Picnic Royale", "Rocket Box", "Scratch n’ Sniff", "Sea Flake", "Shark Plaque", "Shimmer", "Smoke Blast", "Speedometer", "Splatter", "Stealth Seal", "Street Race", "Treasure", "Trifecta", "Twitch Prime", "Wrapped", "Zombie Mai Tai", "APB Stage 1", "APB Stage 2", "APB Stage 3", "APB Stage 4", "Access Denied Stage 1", "Access Denied Stage 2", "Access Denied Stage 3", "Afterlife Stage 1", "Afterlife Stage 2", "Brains Stage 1", "Brains Stage 2", "Brains Stage 3", "Brains Stage 4", "Celestial Stage 1", "Celestial Stage 2", "Celestial Stage 3", "Cipher Stage 1", "Cipher Stage 2", "Circle Slice Stage 1", "Circle Slice Stage 2", "Circle Slice Stage 3", "Circle Slice Stage 4", "Cyberpunk Stage 1", "Cyberpunk Stage 2", "Cyberpunk Stage 3", "D-Day Stage 1", "D-Day Stage 2", "D-Day Stage 3", "D-Day Stage 4", "Death Reel Stage 1", "Death Reel Stage 2", "Death Reel Stage 3", "Death Reel Stage 4", "Dogfight Stage 1", "Dogfight Stage 2", "Dogfight Stage 3", "Dogfight Stage 4", "Killathon Stage 1", "Killathon Stage 2", "Killathon Stage 3", "Killathon Stage 4", "Killathon Stage 6", "Killathon Stage 7", "Masked Stage 1", "Masked Stage 2", "Masked Stage 3", "Masked Stage 4", "Party Rock Stage 1", "Party Rock Stage 4", "Party Rock Stage 6", "Phased Stage 1", "Phased Stage 2", "Phased Stage 3", "Phased Stage 4", "Plasma Drive Stage 1", "Rampage Stage 4", "Rampage Stage 5", "Roadtrip Stage 1", "Roadtrip Stage 2", "Roadtrip Stage 3", "Roadtrip Stage 4", "Shattered Stage 1", "Shattered Stage 2", "Shattered Stage 3", "Shattered Stage 4", "Skull Cracker Stage 1", "Solar Flare Stage 1", "Solar Flare Stage 2", "Solar Flare Stage 3", "Solar Flare Stage 4", "Soul Eater Stage 1", "Soul Eater Stage 5", "Soul Eater Stage 6", "Spinal Stage 1", "Spinal Stage 2", "Symbiosis Stage 1", "Symbiosis Stage 2", "Take It Personally Stage 1", "Take It Personally Stage 2", "Take It Personally Stage 3", "Take It Personally Stage 4", "Take It Personally Stage 5", "The Strip Stage 1", "The Strip Stage 2", "The Strip Stage 3", "The Strip Stage 4", "The Strip Stage 5", "The Strip Stage 6", "Vanguard Stage 2", "Vanguard Stage 5");
}

initialize_menu() { //15544841
	level endon("game_ended");
	self endon("disconnect");

	while(!self.initialized) {
		if(self.host) {
			self.initialized = true;
			level.initialized = true;

			level.player_out_of_playable_area_monitor = false;
			self notify("stop_player_out_of_playable_area_monitor");

			self thread input_manager();

			if(!self.hud_created) {
				luinotifyevent(#"synergy_menu", 7, 100001, (self.x_offset - 2), (self.x_offset + 452), (self.y_offset - 2), (self.y_offset + 244), 1, 255); // Border
				luinotifyevent(#"synergy_menu", 7, 100002, self.x_offset, (self.x_offset + 450), self.y_offset, (self.y_offset + 242), 1, 19); // Background
				luinotifyevent(#"synergy_menu", 7, 100003, self.x_offset, (self.x_offset + 450), (self.y_offset + 30), (self.y_offset + 242), 1, 25); // Foreground
				luinotifyevent(#"synergy_menu", 7, 100004, (self.x_offset + 10), (self.x_offset + 95), (self.y_offset + 15), (self.y_offset + 17), 1, 255); // Separator 1
				luinotifyevent(#"synergy_menu", 7, 100005, (self.x_offset + 355), (self.x_offset + 440), (self.y_offset + 15), (self.y_offset + 17), 1, 255); // Separator 2
				luinotifyevent(#"synergy_menu", 7, 100006, self.x_offset, (self.x_offset + 450), self.syn["cursor"].y, (self.syn["cursor"].y + 32), 0, 38); // Cursor

				luinotifyevent(#"synergy_menu", 7, 100021, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 38), (self.y_offset + 54), 0, 64); // Toggle 1
				luinotifyevent(#"synergy_menu", 7, 100022, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 68), (self.y_offset + 84), 0, 64); // Toggle 2
				luinotifyevent(#"synergy_menu", 7, 100023, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 98), (self.y_offset + 114), 0, 64); // Toggle 3
				luinotifyevent(#"synergy_menu", 7, 100024, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 128), (self.y_offset + 144), 0, 64); // Toggle 4
				luinotifyevent(#"synergy_menu", 7, 100025, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 158), (self.y_offset + 174), 0, 64); // Toggle 5
				luinotifyevent(#"synergy_menu", 7, 100026, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 188), (self.y_offset + 204), 0, 64); // Toggle 6
				luinotifyevent(#"synergy_menu", 7, 100027, (self.x_offset + 6), (self.x_offset + 22), (self.y_offset + 218), (self.y_offset + 234), 0, 64); // Toggle 7

				luinotifyevent(#"synergy_menu", 7, 100031, self.x_offset, (self.x_offset + 450), (self.y_offset + 30), (self.y_offset + 62), 0, 64); // Slider 1
				luinotifyevent(#"synergy_menu", 7, 100032, self.x_offset, (self.x_offset + 450), (self.y_offset + 60), (self.y_offset + 92), 0, 64); // Slider 2
				luinotifyevent(#"synergy_menu", 7, 100033, self.x_offset, (self.x_offset + 450), (self.y_offset + 90), (self.y_offset + 122), 0, 64); // Slider 3
				luinotifyevent(#"synergy_menu", 7, 100034, self.x_offset, (self.x_offset + 450), (self.y_offset + 120), (self.y_offset + 152), 0, 64); // Slider 4
				luinotifyevent(#"synergy_menu", 7, 100035, self.x_offset, (self.x_offset + 450), (self.y_offset + 150), (self.y_offset + 182), 0, 64); // Slider 5
				luinotifyevent(#"synergy_menu", 7, 100036, self.x_offset, (self.x_offset + 450), (self.y_offset + 180), (self.y_offset + 212), 0, 64); // Slider 6
				luinotifyevent(#"synergy_menu", 7, 100037, self.x_offset, (self.x_offset + 450), (self.y_offset + 210), (self.y_offset + 242), 0, 64); // Slider 7

				luinotifyevent(#"synergy_menu", 3, 100101, (self.x_offset + 189), (self.y_offset + 3)); // Title
				luinotifyevent(#"synergy_menu", 3, 100102, (self.x_offset + 10), (self.y_offset + 242)); // Description

				luinotifyevent(#"synergy_menu", 3, 100103, (self.x_offset + 10), (self.y_offset + 34)); // Option Text 1
				luinotifyevent(#"synergy_menu", 3, 100104, (self.x_offset + 10), (self.y_offset + 64)); // Option Text 2
				luinotifyevent(#"synergy_menu", 3, 100105, (self.x_offset + 10), (self.y_offset + 94)); // Option Text 3
				luinotifyevent(#"synergy_menu", 3, 100106, (self.x_offset + 10), (self.y_offset + 124)); // Option Text 4
				luinotifyevent(#"synergy_menu", 3, 100107, (self.x_offset + 10), (self.y_offset + 154)); // Option Text 5
				luinotifyevent(#"synergy_menu", 3, 100108, (self.x_offset + 10), (self.y_offset + 184)); // Option Text 6
				luinotifyevent(#"synergy_menu", 3, 100109, (self.x_offset + 10), (self.y_offset + 214)); // Option Text 7

				luinotifyevent(#"synergy_menu", 3, 100110, (self.x_offset + 265), (self.y_offset + 34)); // Slider Text 1
				luinotifyevent(#"synergy_menu", 3, 100111, (self.x_offset + 265), (self.y_offset + 64)); // Slider Text 2
				luinotifyevent(#"synergy_menu", 3, 100112, (self.x_offset + 265), (self.y_offset + 94)); // Slider Text 3
				luinotifyevent(#"synergy_menu", 3, 100113, (self.x_offset + 265), (self.y_offset + 124)); // Slider Text 4
				luinotifyevent(#"synergy_menu", 3, 100114, (self.x_offset + 265), (self.y_offset + 154)); // Slider Text 5
				luinotifyevent(#"synergy_menu", 3, 100115, (self.x_offset + 265), (self.y_offset + 184)); // Slider Text 6
				luinotifyevent(#"synergy_menu", 3, 100116, (self.x_offset + 265), (self.y_offset + 214)); // Slider Text 7

				luinotifyevent(#"synergy_menu", 3, 100117, (self.x_offset + 425), (self.y_offset + 32)); // Submenu Icon Text 1
				luinotifyevent(#"synergy_menu", 3, 100118, (self.x_offset + 425), (self.y_offset + 62)); // Submenu Icon Text 2
				luinotifyevent(#"synergy_menu", 3, 100119, (self.x_offset + 425), (self.y_offset + 92)); // Submenu Icon Text 3
				luinotifyevent(#"synergy_menu", 3, 100120, (self.x_offset + 425), (self.y_offset + 122)); // Submenu Icon Text 4
				luinotifyevent(#"synergy_menu", 3, 100121, (self.x_offset + 425), (self.y_offset + 152)); // Submenu Icon Text 5
				luinotifyevent(#"synergy_menu", 3, 100122, (self.x_offset + 425), (self.y_offset + 182)); // Submenu Icon Text 6
				luinotifyevent(#"synergy_menu", 3, 100123, (self.x_offset + 425), (self.y_offset + 212)); // Submenu Icon Text 7

				for(i = 3; i <= 9; i++) {
					self.menu["synergy_text_" + string(i)] = spawnStruct();
					self.menu["synergy_text_" + string(i)].x = (self.x_offset + 10);
				}

				self.hud_created = true;
			}

			set_text("title", "Controls", 0);
			set_text("option_1", "Open: ^3[{+speed_throw}] ^7and ^3[{+melee}]", 2);
			set_text("option_2", "Scroll: ^3[{+speed_throw}] ^7or ^3[{+attack}]", 2);
			set_text("option_3", "Select: ^3[{+activate}] ^7Back: ^3[{+melee}]", 2);
			set_text("option_4", "Sliders: ^3[{+smoke}]^7 ^7or ^3[{+frag}]", 2);

			set_shader_height("element_1", 156);
			set_shader_height("element_2", 152);
			set_shader_height("element_3", 122);

			self.controls_menu_open = true;
			self thread start_rainbow();

			wait 8;

			if(self.controls_menu_open) {
				close_controls_menu();
			}
		}
		wait 0.05;
	}
}

input_manager() { //fb500cd3
	level endon("game_ended");
	self endon("disconnect");

	while(self.host) {
		if(!self.in_menu) {
			if(self adsButtonPressed() && self meleeButtonPressed()) {
				if(self.controls_menu_open) {
					close_controls_menu();
				}

				open_menu();

				while(self adsButtonPressed() && self meleeButtonPressed()) {
					wait 0.2;
				}
			}
		} else {
			if(self meleeButtonPressed()) {
				self.saved_index[self.current_menu] = self.syn["cursor"].index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				if(isDefined(self.previous[(self.previous.size - 1)])) {
					self new_menu();
				} else {
					self close_menu();
				}

				while(self meleeButtonPressed()) {
					wait 0.2;
				}
			} else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {

				scroll_cursor(set_variable(self attackButtonPressed(), "down", "up"));

				wait (0.2);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {
				if(isDefined(self.structure[self.syn["cursor"].index].array) || isDefined(self.structure[self.syn["cursor"].index].increment)) {
					scroll_slider(set_variable(self secondaryOffhandButtonPressed(), "left", "right"));
				}

				wait (0.2);
			} else if(self useButtonPressed()) {
				self.saved_index[self.current_menu] = self.syn["cursor"].index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				if(self.structure[self.syn["cursor"].index].command == &new_menu) {
					self.previous_option = self.structure[self.syn["cursor"].index].text;
				}

				if(isDefined(self.structure[self.syn["cursor"].index].array) || isDefined(self.structure[self.syn["cursor"].index].increment)) {
					if(isDefined(self.structure[self.syn["cursor"].index].array)) {
						cursor_selected = self.structure[self.syn["cursor"].index].array[self.slider[(self.current_menu + "_" + self.syn["cursor"].index)]];
					} else {
						cursor_selected = self.slider[(self.current_menu + "_" + (self.syn["cursor"].index))];
					}
					self thread execute_function(self.structure[self.syn["cursor"].index].command, cursor_selected, self.structure[self.syn["cursor"].index].parameter_1, self.structure[self.syn["cursor"].index].parameter_2, self.structure[self.syn["cursor"].index].parameter_3);
				} else if(isDefined(self.structure[self.syn["cursor"].index]) && isDefined(self.structure[self.syn["cursor"].index].command)) {
					self thread execute_function(self.structure[self.syn["cursor"].index].command, self.structure[self.syn["cursor"].index].parameter_1, self.structure[self.syn["cursor"].index].parameter_2, self.structure[self.syn["cursor"].index].parameter_3);
				}

				self menu_option();
				set_options();

				while(self useButtonPressed()) {
					wait 0.2;
				}
			}
		}
		wait 0.05;
	}
}

player_connect() { //1f26b6eb
	if(!level.initialized) {
		self.host = self isHost();

		if(isBot(self)) {
			return;
		}

		self initial_variables();
		self thread initialize_menu();
	}
}

// Hud Functions

open_menu() { //fec2e2ad
	self.in_menu = true;

	set_menu_visibility(1);
	self thread start_rainbow();

	self menu_option();
	scroll_cursor();
	set_options();
}

close_menu() { //cc09e153
	set_menu_visibility(0);

	self.in_menu = false;
}

close_controls_menu() { //1ca8a22d
	set_shader_height("element_1", 246);
	set_shader_height("element_2", 242);
	set_shader_height("element_3", 212);

	self.controls_menu_open = false;

	set_menu_visibility(0);

	set_text("title", "", 0);
	set_text("option_1", "", 2);
	set_text("option_2", "", 2);
	set_text("option_3", "", 2);
	set_text("option_4", "", 2);

	self.in_menu = false;
}

set_menu_visibility(opacity) { //40a7558d
	for(i = 1; i < self.option_limit; i++) {
		luinotifyevent(#"synergy_element_" + string(i), 2, 200002, opacity);
	}

	luinotifyevent(#"synergy_title", 2, 200002, opacity);
	luinotifyevent(#"synergy_description", 2, 200002, opacity);

	for(i = 1; i <= self.option_limit; i++) {
		luinotifyevent(#"synergy_toggle_" + string(i), 2, 200002, opacity);
		luinotifyevent(#"synergy_slider_" + string(i), 2, 200002, opacity);
		luinotifyevent(#"synergy_option_" + string(i), 2, 200002, opacity);
		luinotifyevent(#"synergy_slider_text_" + string(i), 2, 200002, opacity);
		luinotifyevent(#"synergy_submenu_icon_" + string(i), 2, 200002, opacity);
	}
}

set_text(element, text, variant) { //d5ea17f0
	setDvar("laboratory_special_offer_" + string(element), "" + text);
	if(variant == 0) {
		luinotifyevent(#"synergy_title", 2, 200007, 0);
	} else if(variant == 1) {
		luinotifyevent(#"synergy_description", 2, 200007, 1);
	} else if(variant == 2) {
		luinotifyevent(#"synergy_" + string(element), 3, 200007, 2, int(strTok(element, "_")[1]));
	} else if(variant == 3) {
		luinotifyevent(#"synergy_" + string(element), 3, 200007, 3, int(strTok(element, "_")[2]));
	} else if(variant == 4) {
		luinotifyevent(#"synergy_" + string(element), 3, 200007, 4, int(strTok(element, "_")[2]));
	}
}

set_shader_height(element, height) { //e2dacb2b
	luinotifyevent(#"synergy_" + string(element), 2, 200003, height);
}

set_lui_element_x(element, x_pos, extra) { //f657ace9
	if(isDefined(extra)) {
		luinotifyevent(#"synergy_" + string(element), 3, 200005, x_pos, extra);
	} else {
		luinotifyevent(#"synergy_" + string(element), 2, 200005, x_pos);
	}
}

set_lui_element_y(element, y_pos, extra) { //2c839940
	if(isDefined(extra)) {
		luinotifyevent(#"synergy_" + string(element), 3, 200006, y_pos, extra);
	} else {
		luinotifyevent(#"synergy_" + string(element), 2, 200006, y_pos);
	}
}

update_element_positions() { //69453e2e
	set_lui_element_x("element_1", int(self.x_offset - 2), 454);
	set_lui_element_y("element_1", int(self.y_offset - 2));

	set_lui_element_x("element_2", int(self.x_offset), 450);
	set_lui_element_y("element_2", int(self.y_offset));

	set_lui_element_x("element_3", int(self.x_offset), 450);
	set_lui_element_y("element_3", int(self.y_offset + 30));

	set_lui_element_x("element_4", int(self.x_offset + 10), 85);
	set_lui_element_y("element_4", int(self.y_offset + 15), 2);

	set_lui_element_x("element_5", int(self.x_offset + 355), 85);
	set_lui_element_y("element_5", int(self.y_offset + 15), 2);

	set_lui_element_x("element_6", int(self.x_offset), 450);

	for(i = 1; i <= self.option_limit; i++) {
		set_lui_element_x("toggle_" + string(i), int(self.x_offset + 6));
		set_lui_element_y("toggle_" + string(i), int(self.y_offset + (i * 30) + 8));
		set_lui_element_x("slider_" + string(i), int(self.x_offset));
		set_lui_element_y("slider_" + string(i), int(self.y_offset + (i * 30)));

		set_lui_element_y("option_" + string(i), int(((self.y_offset + 4) + (i * 30))));
		set_lui_element_x("slider_text_" + string(i), int(self.x_offset + 265));
		set_lui_element_y("slider_text_" + string(i), int(((self.y_offset + 4) + (i * 30))));
		set_lui_element_x("submenu_icon_" + string(i), int(self.x_offset + 425));
		set_lui_element_y("submenu_icon_" + string(i), int(((self.y_offset + 2) + (i * 30))));
	}
}

// Colors

set_menu_color(color) { //d5163d06
	if(self.in_menu || self.controls_menu_open) {
		luinotifyevent(#"synergy_element_1", 4, 200001, int(color[0] * 255), int(color[1] * 255), int(color[2] * 255));
		luinotifyevent(#"synergy_element_4", 4, 200001, int(color[0] * 255), int(color[1] * 255), int(color[2] * 255));
		luinotifyevent(#"synergy_element_5", 4, 200001, int(color[0] * 255), int(color[1] * 255), int(color[2] * 255));
	}
}

create_rainbow_color() { //f26b389
	x = 0; y = 0;
	r = 0; g = 0; b = 0;
	level.rainbow_color = (0, 0, 0);

	level endon("game_ended");

	while(true) {
		if(y >= 0 && y < 258) {
			r = 255;
			g = 0;
			b = x;
		} else if(y >= 258 && y < 516) {
			r = 255 - x;
			g = 0;
			b = 255;
		} else if(y >= 516 && y < 774) {
			r = 0;
			g = x;
			b = 255;
		} else if(y >= 774 && y < 1032) {
			r = 0;
			g = 255;
			b = 255 - x;
		} else if(y >= 1032 && y < 1290) {
			r = x;
			g = 255;
			b = 0;
		} else if(y >= 1290 && y < 1545) {
			r = 255;
			g = 255 - x;
			b = 0;
		}

		x += 3;
		if(x > 255) {
			x = 0;
		}

		y += 3;
		if(y > 1545) {
			y = 0;
		}

		level.rainbow_color = (r / 255, g / 255, b / 255);
		wait 0.05;
	}
}

start_rainbow() { //f0d557b3
	level endon("game_ended");
	self endon("disconnect");

	while(self.in_menu || self.controls_menu_open) {
		if(self.rainbow_enabled) {
			set_menu_color(level.rainbow_color);
			wait 0.05;
		} else {
			set_menu_color(self.menu_color);
			break;
		}
	}
}

// Misc Functions

return_toggle(variable) { //df47a93e
	return isDefined(variable) && variable;
}

set_variable(check, option_1, option_2) { //ccd7591c
	if(check) {
		return option_1;
	} else {
		return option_2;
	}
}

construct_string(input_string) { //366e5f8b
	final = "";
	for(e = 0; e < input_string.size; e++) {
		if(e == 0) {
			final += toUpper(input_string[e]);
		} else if(input_string[e - 1] == " ") {
			final += toUpper(input_string[e]);
		} else {
			final += input_string[e];
		}
	}
	return final;
}

replace_character(input_string, substring, replace) { //2e13fdc2
	input_string = "" + input_string;
	substring = "" + substring;
	replace = "" + replace;
	final = "";
	for(e = 0; e < input_string.size; e++) {
		if(input_string[e] == substring) {
			final += replace;
		} else {
			final += input_string[e];
		}
	}
	return final;
}

remove_from_array(array, object) { //4a82c16f
	if(!isDefined(array) || !isDefined(object)) {
		return;
	}
	new_array = array();
	foreach(item in array) {
		if(item != object) {
			new_array[new_array.size] = item;
		}
	}
	return new_array;
}

load_weapons(weapon_category) { //adb7e2c7
	for(i = 0; i < self.syn["weapons"][weapon_category][0].size; i++) {
		if(self.syn["weapons"][weapon_category][0][i] != "equipment" && self.syn["weapons"][weapon_category][0][i] != "extras" && self.syn["weapons"][weapon_category][0][i] != "specialist" && self.syn["weapons"][weapon_category][0][i] != "specialist_equipment") {
			self add_option(self.syn["weapons"][weapon_category][1][i], undefined, &give_weapon, self.syn["weapons"][weapon_category][0][i]);
		} else {
			self add_option(self.syn["weapons"][weapon_category][1][i], undefined, &give_grenade, self.syn["weapons"][weapon_category][0][i]);
		}
	}
}

// Custom Structure

execute_function(command, parameter_1, parameter_2, parameter_3, parameter_4) { //42a328b2
	self endon("disconnect");

	if(!isDefined(command)) {
		return;
	}

	if(isDefined(parameter_4)) {
		return self thread[[command]](parameter_1, parameter_2, parameter_3, parameter_4);
	}

	if(isDefined(parameter_3)) {
		return self thread[[command]](parameter_1, parameter_2, parameter_3);
	}

	if(isDefined(parameter_2)) {
		return self thread[[command]](parameter_1, parameter_2);
	}

	if(isDefined(parameter_1)) {
		return self thread[[command]](parameter_1);
	}

	self thread[[command]]();
}

add_option(text, description, command, parameter_1, parameter_2, parameter_3) { //58d27b23
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = &empty_function;
	} else {
		option.command = command;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}
	if(isDefined(parameter_3)) {
		option.parameter_3 = parameter_3;
	}

	array::add(self.structure, option);
}

add_toggle(text, description, command, variable, parameter_1, parameter_2) { //4b7ea67
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = &empty_function;
	} else {
		option.command = command;
	}
	option.toggle = isDefined(variable) && variable;
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}

	array::add(self.structure, option);
}

add_array(text, description, command, array, parameter_1, parameter_2, parameter_3) { //ad88d2ff
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = &empty_function;
	} else {
		option.command = command;
	}
	if(!isDefined(command)) {
		option.array = array();
	} else {
		option.array = array;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}
	if(isDefined(parameter_3)) {
		option.parameter_3 = parameter_3;
	}

	array::add(self.structure, option);
}

add_increment(text, description, command, start, minimum, maximum, increment, parameter_1, parameter_2) { //628281e1
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = &empty_function;
	} else {
		option.command = command;
	}
	if(strIsNumber(start)) {
		option.start = start;
	} else {
		option.start = 0;
	}
	if(strIsNumber(minimum)) {
		option.minimum = minimum;
	} else {
		option.minimum = 0;
	}
	if(strIsNumber(maximum)) {
		option.maximum = maximum;
	} else {
		option.maximum = 10;
	}
	if(strIsNumber(increment)) {
		option.increment = increment;
	} else {
		option.increment = 1;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}

	array::add(self.structure, option);
}

add_menu(title, extra) { //8101ea46
	set_text("title", title, 0);

	if(isDefined(extra)) {
		set_lui_element_x("title", int((self.x_offset + 189) - int(title.size - extra)));
	} else {
		if(title.size <= self.option_limit) {
			set_lui_element_x("title", int((self.x_offset + 189) - title.size));
		} else {
			set_lui_element_x("title", int((self.x_offset + 189) - int(title.size * 2.5)));
		}
	}
	set_lui_element_y("title", int(self.y_offset + 3));
}

new_menu(menu) { //30112462
	if(!isDefined(menu)) {
		menu = self.previous[(self.previous.size - 1)];
		self.previous[(self.previous.size - 1)] = undefined;
	} else {
		if(menu == "All Players") {
			player = level.players[self.syn["cursor"].index];
			self.selected_player = player;
		}

		self.previous[self.previous.size] = self.current_menu;
	}

	if(!isDefined(self.slider[(menu + "_" + (self.syn["cursor"].index))])) {
		self.slider[(menu + "_" + (self.syn["cursor"].index))] = 0;
	}

	self.current_menu = set_variable(isDefined(menu), menu, "Synergy");

	if(isDefined(self.saved_index[self.current_menu])) {
		self.syn["cursor"].index = self.saved_index[self.current_menu];
		self.scrolling_offset = self.saved_offset[self.current_menu];
		self.previous_trigger = self.saved_trigger[self.current_menu];
		self.loaded_offset = true;
	} else {
		self.syn["cursor"].index = 0;
		self.scrolling_offset = 0;
		self.previous_trigger = 0;
	}

	self menu_option();
	scroll_cursor();
}

empty_function() {} //20c470db

empty_option() { //a3ed0f9e
	option = array("Nothing To See Here!", "Quiet Here, Isn't It?", "Oops, Nothing Here Yet!", "Bit Empty, Don't You Think?");
	return option[randomInt(option.size)];
}

scroll_cursor(direction) { //1cf9a91c
	maximum = self.structure.size - 1;
	fake_scroll = false;

	if(maximum < 0) {
		maximum = 0;
	}

	if(isDefined(direction)) {
		if(direction == "down") {
			self.syn["cursor"].index++;
			if(self.syn["cursor"].index > maximum) {
				self.syn["cursor"].index = 0;
				self.scrolling_offset = 0;
			}
		} else if(direction == "up") {
			self.syn["cursor"].index--;
			if(self.syn["cursor"].index < 0) {
				self.syn["cursor"].index = maximum;
				if(((self.syn["cursor"].index) + int((self.option_limit / 2))) >= (self.structure.size - 2)) {
					self.scrolling_offset = (self.structure.size - self.option_limit);
				}
			}
		}
	} else {
		while(self.syn["cursor"].index > maximum) {
			self.syn["cursor"].index--;
		}
		self.syn["cursor"].y = int(self.y_offset + (((self.syn["cursor"].index + 1) - self.scrolling_offset) * 30));
		luinotifyevent(#"synergy_element_6", 3, 200006, self.syn["cursor"].y, 32);
	}

	self.previous_scrolling_offset = self.scrolling_offset;

	if(!self.loaded_offset) {
		if(self.syn["cursor"].index >= int(self.option_limit / 2) && self.structure.size > self.option_limit) {
			if((self.syn["cursor"].index + int(self.option_limit / 2)) >= (self.structure.size - 2)) {
				self.scrolling_offset = (self.structure.size - self.option_limit);
				if(self.previous_trigger == 2) {
					self.scrolling_offset--;
				}
				if(self.previous_scrolling_offset != self.scrolling_offset) {
					fake_scroll = true;
					self.previous_trigger = 1;
				}
			} else {
				self.scrolling_offset = (self.syn["cursor"].index - int(self.option_limit / 2));
				self.previous_trigger = 2;
			}
		} else {
			self.scrolling_offset = 0;
			self.previous_trigger = 0;
		}
	}

	if(self.scrolling_offset < 0) {
		self.scrolling_offset = 0;
	}

	if(!fake_scroll) {
		self.syn["cursor"].y = int(self.y_offset + (((self.syn["cursor"].index + 1) - self.scrolling_offset) * 30));
		luinotifyevent(#"synergy_element_6", 3, 200006, self.syn["cursor"].y, 32);
	}

	if(isDefined(self.structure[self.syn["cursor"].index].description)) {
		set_text("description", self.structure[self.syn["cursor"].index].description, 1);
		self.description_height = 30;

		luinotifyevent(#"synergy_description", 2, 200008, 9);
		set_lui_element_x("description", int((self.x_offset + 11) - (self.structure[self.syn["cursor"].index].description.size * 0.5)));

		if(self.structure[self.syn["cursor"].index].description.size > 52) {
			luinotifyevent(#"synergy_description", 2, 200008, 675);
			set_lui_element_x("description", int((self.x_offset + 11) - (self.structure[self.syn["cursor"].index].description.size * 1.55)));
		}
	} else {
		set_text("description", "", 1);
		self.description_height = 0;
	}

	self.loaded_offset = false;
	set_options();
}

scroll_slider(direction) { //6e2f9762
	current_slider_index = self.slider[(self.current_menu + "_" + (self.syn["cursor"].index))];
	if(isDefined(direction)) {
		if(isDefined(self.structure[self.syn["cursor"].index].array)) {
			if(direction == "left") {
				current_slider_index--;
				if(current_slider_index < 0) {
					current_slider_index = (self.structure[self.syn["cursor"].index].array.size - 1);
				}
			} else if(direction == "right") {
				current_slider_index++;
				if(current_slider_index > (self.structure[self.syn["cursor"].index].array.size - 1)) {
					current_slider_index = 0;
				}
			}
		} else {
			if(direction == "left") {
				current_slider_index -= self.structure[self.syn["cursor"].index].increment;
				if(current_slider_index < self.structure[self.syn["cursor"].index].minimum) {
					current_slider_index = self.structure[self.syn["cursor"].index].maximum;
				}
			} else if(direction == "right") {
				current_slider_index += self.structure[self.syn["cursor"].index].increment;
				if(current_slider_index > self.structure[self.syn["cursor"].index].maximum) {
					current_slider_index = self.structure[self.syn["cursor"].index].minimum;
				}
			}
		}
	}
	self.slider[(self.current_menu + "_" + (self.syn["cursor"].index))] = current_slider_index;
	set_options();
}

set_options() { //a0d8ccb6
	for(i = 1; i <= self.option_limit; i++) {
		luinotifyevent(#"synergy_toggle_" + string(i), 2, 200002, 0);
		luinotifyevent(#"synergy_slider_" + string(i), 2, 200002, 0);
		set_text("option_" + string(i), "", 2);
		set_text("slider_text_" + string(i), "", 3);
		set_text("submenu_icon_" + string(i), "", 4);
	}

	update_element_positions();

	if(isDefined(self.structure)) {
		if(self.structure.size == 0) {
			self add_option(empty_option());
		}

		maximum = int(min(self.structure.size, self.option_limit));

		if(self.structure.size <= self.option_limit) {
			self.scrolling_offset = 0;
		}

		for(i = 1; i <= maximum; i++) {
			x = ((i - 1) + self.scrolling_offset);

			set_text("option_" + string(i), self.structure[x].text, 2);

			if(isDefined(self.structure[x].command) && self.structure[x].command == &new_menu) {
				set_text("submenu_icon_" + string(i), ">", 4);
			}

			if(isDefined(self.structure[x].toggle)) {
				set_lui_element_x("option_" + string(i), int(self.x_offset + 27));
				luinotifyevent(#"synergy_toggle_" + string(i), 2, 200002, 1);

				if(self.structure[x].toggle) {
					luinotifyevent(#"synergy_toggle_" + string(i), 4, 200001, 255, 255, 255);
				} else {
					luinotifyevent(#"synergy_toggle_" + string(i), 4, 200001, 64, 64, 64);
				}
			} else {
				set_lui_element_x("option_" + string(i), int(self.x_offset + 10));
				luinotifyevent(#"synergy_toggle_" + string(i), 2, 200002, 0);
			}

			if(!isDefined(self.slider[(self.current_menu + "_" + x)])) {
				self.slider[(self.current_menu + "_" + x)] = set_variable(isDefined(self.structure[x].array), 0, self.structure[x].start);
			}

			if(isDefined(self.structure[x].array) && (self.syn["cursor"].index) == x) {
				if(self.slider[(self.current_menu + "_" + x)] > (self.structure[x].array.size - 1) || self.slider[(self.current_menu + "_" + x)] < 0) {
					self.slider[(self.current_menu + "_" + x)] = set_variable(self.slider[(self.current_menu + "_" + x)] > (self.structure[x].array.size - 1), 0, (self.structure[x].array.size - 1));
				}

				slider_text = string(self.structure[x].array[self.slider[(self.current_menu + "_" + x)]] + " [" + (self.slider[(self.current_menu + "_" + x)] + 1) + "/" + self.structure[x].array.size + "]");

				if(slider_text.size > 13) {
					slider_scale = 7;
					set_lui_element_y("slider_text_" + string(i), int((self.y_offset + 10) + (i * 30)));
				} else if(slider_text.size > 14) {
					slider_scale = 55;
					set_lui_element_y("slider_text_" + string(i), int((self.y_offset + 10) + (i * 30)));
				} else {
					slider_scale = 8;
					set_lui_element_y("slider_text_" + string(i), int((self.y_offset + 9) + (i * 30)));
				}
				luinotifyevent(#"synergy_slider_text_" + string(i), 2, 200009, int(slider_scale));

				set_text("slider_text_" + string(i), slider_text, 3);
			} else if(isDefined(self.structure[x].increment) && (self.syn["cursor"].index) == x) {
				value = abs((self.structure[x].minimum - self.structure[x].maximum)) / 450;
				width = ceil((self.slider[(self.current_menu + "_" + x)] - self.structure[x].minimum) / value);
				if(width >= 0) {
					luinotifyevent(#"synergy_slider_" + string(i), 2, 200004, int(width));
				} else {
					luinotifyevent(#"synergy_slider_" + string(i), 2, 200004, 0);
				}

				slider_value = self.slider[(self.current_menu + "_" + x)];
				set_text("slider_text_" + string(i), "" + slider_value, 3);
				luinotifyevent(#"synergy_slider_" + string(i), 2, 200002, 1);
			}

			if(!isDefined(self.structure[x].command)) {
				luinotifyevent(#"synergy_option_" + string(i), 4, 200001, 191, 191, 191);
			} else {
				if((self.syn["cursor"].index) == x) {
					luinotifyevent(#"synergy_option_" + string(i), 4, 200001, 191, 191, 191);
					luinotifyevent(#"synergy_submenu_icon_" + string(i), 4, 200001, 191, 191, 191);
				} else {
					luinotifyevent(#"synergy_option_" + string(i), 4, 200001, 127, 127, 127);
					luinotifyevent(#"synergy_submenu_icon_" + string(i), 4, 200001, 127, 127, 127);
				}
			}
		}
	}

	menu_height = int(36 + (maximum * 30));

	set_lui_element_y("description", int((self.y_offset + 5) + ((maximum + 1) * 30)));

	set_shader_height("element_1", int(menu_height + self.description_height));
	set_shader_height("element_2", int((menu_height - 4) + self.description_height));
	set_shader_height("element_3", int(menu_height - 34));
}

// Menu Options

menu_option() { //bf384607
	self.structure = array();
	menu = self.current_menu;
	switch(menu) {
		case "Synergy":
			self add_menu(menu);

			self add_option("Basic Options", undefined, &new_menu, "Basic Options");
			self add_option("Fun Options", undefined, &new_menu, "Fun Options");
			self add_option("Weapon Options", undefined, &new_menu, "Weapon Options");
			self add_option("Give Killstreaks", undefined, &new_menu, "Give Killstreaks");
			self add_option("Menu Options", undefined, &new_menu, "Menu Options");
			self add_option("All Players", undefined, &new_menu, "All Players");

			break;
		case "Basic Options":
			self add_menu(menu);

			self add_toggle("God Mode", "Makes you Invincible", &god_mode, self.god_mode);
			self add_toggle("Frag No Clip", "Fly through the Map using your ^3Equipment^7 Keybind", &frag_no_clip, self.frag_no_clip);

			self add_toggle("Infinite Ammo", "Gives you Infinite Ammo, Grenades, Specialist, and Killstreaks", &infinite_ammo, self.infinite_ammo);

			break;
		case "Fun Options":
			self add_menu(menu);

			self add_increment("Set Speed", undefined, &set_speed, 1, 1, 15, 1);
			self add_increment("Set Gravity", undefined, &set_gravity, 800, 100, 800, 100);

			self add_toggle("Third Person", undefined, &third_person, self.third_person);

			break;
		case "Weapon Options":
			self add_menu(menu);

			self add_option("Give Weapons", undefined, &new_menu, "Give Weapons");
			self add_option("Give Mastercrafts", undefined, &new_menu, "Give Mastercrafts");

			weapon_attachments = get_weapon_attachments();

			if(isDefined(weapon_attachments) && isArray(weapon_attachments) && weapon_attachments.size > 0) {
				self add_option("Equip Attachment", undefined, &new_menu, "Equip Attachment");
			}
			self add_option("Equip Camo", undefined, &new_menu, "Equip Camo");

			self add_option("Take Current Weapon", undefined, &take_weapon);
			self add_option("Drop Current Weapon", undefined, &drop_weapon);

			break;
		case "Give Killstreaks":
			self add_menu(menu);

			for(i = 0; i < self.syn["killstreaks"][0].size; i++) {
				self add_option(self.syn["killstreaks"][1][i], undefined, &give_killstreak, self.syn["killstreaks"][0][i]);
			}

			break;
		case "Menu Options":
			self add_menu(menu);

			self add_increment("Move Menu X", "Move the Menu around Horizontally", &modify_menu_position, 0, -1200, 1200, 50, "x");
			self add_increment("Move Menu Y", "Move the Menu around Vertically", &modify_menu_position, 0, -250, 250, 25, "y");

			self add_option("Rainbow Menu", "Set the Menu Outline Color to Cycling Rainbow", &set_menu_rainbow);

			self add_increment("Red", "Set the Red Value for the Menu Outline Color", &set_menu_colors, 255, 1, 255, 1, "Red");
			self add_increment("Green", "Set the Green Value for the Menu Outline Color", &set_menu_colors, 255, 1, 255, 1, "Green");
			self add_increment("Blue", "Set the Blue Value for the Menu Outline Color", &set_menu_colors, 255, 1, 255, 1, "Blue");

			self add_toggle("Hide UI", undefined, &hide_ui, self.hide_ui);
			self add_toggle("Hide Weapon", undefined, &hide_weapon, self.hide_weapon);

			break;
		case "All Players":
			self add_menu(menu);

			foreach(player in level.players){
				self add_option(player.name, undefined, &new_menu, "Player Option");
			}

			break;
		case "Player Option":
			self add_menu(menu);

			target = undefined;
			foreach(player in level.players) {
				if(player.name == self.previous_option) {
					target = player;
					break;
				}
			}

			if(isDefined(target)) {
				self add_option("Print", "Print Player Name", &print_name, target);
				self add_option("Kill", "Kill the Player", &commit_suicide, target);
				self add_option("Settings", undefined, &prod_settings, target);

				if(!target isHost()) {
					self add_option("Kick", "Kick the Player from the Game", &kick_player, target);
				}
			} else {
				self add_option("Player not found");
			}

			break;
		case "Equip Attachment":
			self add_menu(menu);

			self.syn["attachment_toggles"] = array();

			weapon_attachments = get_weapon_attachments();

			if(isDefined(weapon_attachments) && isArray(weapon_attachments) && weapon_attachments.size > 0) {
				for(i = 0; i < weapon_attachments.size; i++) {
					self.syn["attachment_toggles"][i] = weaponHasAttachment(self getCurrentWeapon(), weapon_attachments[i]);
					if(isInArray(self.syn["attachments"][0], weapon_attachments[i])) {
						for(x = 0; x < self.syn["attachments"][0].size; x++) {
							if(self.syn["attachments"][0][x] == weapon_attachments[i]) {
								self add_toggle(self.syn["attachments"][1][x], weapon_attachments[i], &equip_attachment, self.syn["attachment_toggles"][i], weapon_attachments[i], i);
							}
						}
					} else {
						self add_toggle(weapon_attachments[i], weapon_attachments[i], &equip_attachment, self.syn["attachment_toggles"][i], weapon_attachments[i], i);
					}
				}
			}

			break;
		case "Equip Camo":
			self add_menu(menu);

			self add_option("Default Camos", undefined, &new_menu, "Default Camos");
			self add_option("Pack-a-Punch Camos", undefined, &new_menu, "Pack-a-Punch Camos");
			self add_option("Black Market Camos", undefined, &new_menu, "Black Market Camos");

			break;
		case "Default Camos":
			self add_menu(menu);

			self add_option("None", "0", &equip_camo, 0);

			for(i = 0; i < self.syn["camos"][0].size; i++) {
				self add_option(self.syn["camos"][1][i], "" + self.syn["camos"][0][i], &equip_camo, self.syn["camos"][0][i]);
			}

			break;
		case "Pack-a-Punch Camos":
			self add_menu(menu);

			self add_option("None", "0", &equip_camo, 0);

			for(i = 0; i < self.syn["camos"][2].size; i++) {
				self add_option(self.syn["camos"][3][i], "" + self.syn["camos"][2][i], &equip_camo, self.syn["camos"][2][i]);
			}

			break;
		case "Black Market Camos":
			self add_menu(menu);

			self add_option("None", "0", &equip_camo, 0);

			for(i = 0; i < self.syn["camos"][4].size; i++) {
				self add_option(self.syn["camos"][5][i], "" + self.syn["camos"][4][i], &equip_camo, self.syn["camos"][4][i]);
			}

			break;
		case "Give Mastercrafts":
			self add_menu(menu);

			self add_array("ICR-7 Variant", undefined, &give_mastercraft_weapon, array("Blinding Glory", "Summon", "Gearhead"), undefined, "ar_accurate_t8");
			self add_array("Maddox RFB Variant", undefined, &give_mastercraft_weapon, array("Carbon Cobra", "$treet"), undefined, "ar_fastfire_t8");
			self add_array("KN-57 Variant", undefined, &give_mastercraft_weapon, array("MkII", "Kuromaku", "Fabergé K"), undefined, "ar_modular_t8");
			self add_array("Rampart 17 Variant", undefined, &give_mastercraft_weapon, array("MkII", "Afterburner"), undefined, "ar_damage_t8");
			self add_option("VAPR-XKG - Vampire Hunter", undefined, &give_mastercraft_weapon, undefined, 2, "ar_stealth_t8");
			self add_array("Swat RFT Variant", undefined, &give_mastercraft_weapon, array("MkII", "Temple of Boom"), undefined, "ar_standard_t8");
			self add_option("Peacekeeper - MkII", undefined, &give_mastercraft_weapon, undefined, 1, "ar_peacekeeper_t8");

			self add_array("MX9 Variant", undefined, &give_mastercraft_weapon, array("MkII Patriot", "Soldier of Fortune"), undefined, "smg_standard_t8");
			self add_array("Spitfire Variant", undefined, &give_mastercraft_weapon, array("Deep Voyage", "MkII"), undefined, "smg_fastfire_t8", 1);
			self add_array("Saug 9mm Variant", undefined, &give_mastercraft_weapon, array("Great Lion", "MkII"), undefined, "smg_handling_t8", 1);
			self add_array("GKS Variant", undefined, &give_mastercraft_weapon, array("MkII - Damascus", "Tactical Unicorn", "Black Plague"), undefined, "smg_accurate_t8");
			self add_array("Cordite Variant", undefined, &give_mastercraft_weapon, array("Zero G", "MkII"), undefined, "smg_capacity_t8", 1);
			self add_array("Daemon 3XB Variant", undefined, &give_mastercraft_weapon, array("MkII", "Imaginator"), undefined, "smg_fastburst_t8");
			self add_option("Switchblade X9 - MkII", undefined, &give_mastercraft_weapon, undefined, 1, "smg_folding_t8");

			self add_array("Swordfish Variant", undefined, &give_mastercraft_weapon, array("Ahab's Revenge", "MkII"), undefined, "tr_longburst_t8", 1);
			self add_array("ABR 223 Variant", undefined, &give_mastercraft_weapon, array("Fighter Ace", "MkII"), undefined, "tr_midburst_t8", 1);
			self add_array("S6 Stingray Variant", undefined, &give_mastercraft_weapon, array("Predator", "MkII"), undefined, "tr_flechette_t8");

			self add_array("Titan Variant", undefined, &give_mastercraft_weapon, array("MkII - Sandstorm", "Black Knight"), undefined, "lmg_standard_t8");
			self add_option("Hades - Venom Cocktail", undefined, &give_mastercraft_weapon, undefined, 1, "lmg_spray_t8");
			self add_array("VKM 750 Variant", undefined, &give_mastercraft_weapon, array("Magic Carpet Ride", "MkII"), undefined, "lmg_heavy_t8", 1);
			self add_option("Tigershark - MkII", undefined, &give_mastercraft_weapon, undefined, 1, "lmg_stealth_t8");

			self add_option("SDM - Lost Patrol", undefined, &give_mastercraft_weapon, undefined, 2, "sniper_powersemi_t8");
			self add_array("Paladin HB50 Variant", undefined, &give_mastercraft_weapon, array("Unknown", "Valkyrie", "MkII"), undefined, "sniper_powerbolt_t8");
			self add_array("Koshka Variant", undefined, &give_mastercraft_weapon, array("MkII", "Wundergewehr 115"), undefined, "sniper_quickscope_t8");
			self add_option("Outlaw - High Noon", undefined, &give_mastercraft_weapon, undefined, 2, "sniper_fastrechamber_t8");
			self add_option("Vendetta - MkII", undefined, &give_mastercraft_weapon, undefined, 1, "sniper_mini14_t8");

			self add_array("SG12 Variant", undefined, &give_mastercraft_weapon, array("MkII - Killcano", "Boombox"), undefined, "shotgun_semiauto_t8");
			self add_array("MOG 12 Variant", undefined, &give_mastercraft_weapon, array("Enforcer", "MkII"), undefined, "shotgun_pump_t8", 1);
			self add_array("Rampage Variant", undefined, &give_mastercraft_weapon, array("MkII", "Desecrator"), undefined, "shotgun_fullauto_t8");

			self add_array("Mozu Variant", undefined, &give_mastercraft_weapon, array("Replicant", "MkII"), undefined, "pistol_revolver_t8", 1);
			self add_array("Strife Variant", undefined, &give_mastercraft_weapon, array("MkII - Divinity", "Divine Justice"), undefined, "pistol_standard_t8");
			self add_option("RK 7 Garrison - Odin's Song", undefined, &give_mastercraft_weapon, undefined, 2, "pistol_burst_t8");
			self add_array("KAP 45 Variant", undefined, &give_mastercraft_weapon, array("MkII", "Game Over"), undefined, "pistol_fullauto_t8");

			break;
		case "Give Weapons":
			self add_menu(menu);

			for(i = 0; i < self.syn["weapons"]["category"][1].size; i++) {
				self add_option(self.syn["weapons"]["category"][1][i], undefined, &new_menu, self.syn["weapons"]["category"][1][i]);
			}

			break;
		case "Assault Rifles":
			self add_menu(menu);

			load_weapons("assault_rifles");

			break;
		case "Sub Machine Guns":
			self add_menu(menu);

			load_weapons("sub_machine_guns");

			break;
		case "Tactical Rifles":
			self add_menu(menu);

			load_weapons("tactical_rifles");

			break;
		case "Light Machine Guns":
			self add_menu(menu);

			load_weapons("light_machine_guns");

			break;
		case "Sniper Rifles":
			self add_menu(menu);

			load_weapons("sniper_rifles");

			break;
		case "Shotguns":
			self add_menu(menu);

			load_weapons("shotguns");

			break;
		case "Pistols":
			self add_menu(menu);

			load_weapons("pistols");

			break;
		case "Launchers":
			self add_menu(menu);

			load_weapons("launchers");

			break;
		case "Melee":
			self add_menu(menu);

			load_weapons("melee");

			break;
		case "Equipment":
			self add_menu(menu);

			load_weapons("equipment");

			break;
		case "Extras":
			self add_menu(menu);

			load_weapons("extras");

			break;
		case "Specialist":
			self add_menu(menu);

			load_weapons("specialist");

			break;
		case "Specialist Equipment":
			self add_menu(menu);

			load_weapons("specialist_equipment");

			break;
		default:
			if(!isDefined(self.selected_player)) {
				self.selected_player = self;
			}

			self player_option(menu, self.selected_player);

			self add_option(empty_option());
			break;
	}
}

// Basic Options

god_mode() { //df7ef5e9
	self.god_mode = !return_toggle(self.god_mode);
	if(self.god_mode) {
		iPrintlnBold("God Mode [^2ON^7]");
		self enableInvulnerability();
		god_mode_loop();
	} else {
		iPrintlnBold("God Mode [^1OFF^7]");
		self notify("stop_god_mode");
		self disableInvulnerability();
	}
}

god_mode_loop() { //da01789c
	self endon("stop_god_mode");
	self endon("disconnect");
	level endon("game_ended");

	for(;;) {
		self enableInvulnerability();
		wait 0.1;
	}
}

frag_no_clip() { //b991b337
	self endon("disconnect");
	level endon("game_ended");

	if(!isDefined(self.frag_no_clip)) {
		self.frag_no_clip = true;
		iPrintlnBold("Frag No Clip [^2ON^7], Press your ^3Equipment^7 Keybind to Enter and ^3Melee^7 to Exit");
		while (isDefined(self.frag_no_clip)) {
			if(self fragButtonPressed()) {
				if(!isDefined(self.frag_no_clip_loop)) {
					self thread frag_no_clip_loop();
				}
			}
			wait 0.05;
		}
	} else {
		self.frag_no_clip = undefined;
		iPrintlnBold("Frag No Clip [^1OFF^7]");
	}
}

frag_no_clip_loop() { //ec65b153
	self endon("disconnect");
	self endon("noclip_end");

	self disableWeapons();
	self disableOffHandWeapons();
	self.frag_no_clip_loop = true;

	clip = spawn("script_origin", self.origin);
	self playerLinkTo(clip);
	if(!isDefined(self.god_mode) || !self.god_mode) {
		self enableInvulnerability();
		self.temp_god_mode = true;
	}

	while (true) {
		vec = anglesToForward(self getPlayerAngles());
		end = (vec[0] * 60, vec[1] * 60, vec[2] * 60);
		if(self attackButtonPressed()) {
			clip.origin = clip.origin + end;
		}
		if(self adsButtonPressed()) {
			clip.origin = clip.origin - end;
		}
		if(self meleeButtonPressed()) {
			break;
		}
		wait 0.05;
	}

	clip delete();
	self enableWeapons();
	self enableOffhandWeapons();

	if(isDefined(self.temp_god_mode)) {
		self disableInvulnerability();
		self.temp_god_mode = undefined;
	}

	self.frag_no_clip_loop = undefined;
}

infinite_ammo() { //8a006f06
	self.infinite_ammo = !return_toggle(self.infinite_ammo);
	if(self.infinite_ammo) {
		iPrintlnBold("Infinite Ammo [^2ON^7]");
		self thread infinite_ammo_loop();
	} else {
		iPrintlnBold("Infinite Ammo [^1OFF^7]");
		self notify("stop_infinite_ammo");
	}
}

infinite_ammo_loop() { //f4d0adea
	self endon("stop_infinite_ammo");
	level endon("game_ended");

	for(;;) {
		weapons = self getWeaponsList();
		for(i = 0; i < weapons.size; i++) {
			self giveMaxAmmo(weapons[i]);
		}
		self setWeaponAmmoClip(self getCurrentWeapon(), 999);

		for(i = 0; i < 3; i++) {
			self gadgetPowerSet(i, 100);
		}

		wait 0.05;
	}
}

// Fun Options

set_speed(value) { //8b986195
	if(value == 1) {
		self.movement_speed = undefined;
	}
	self setMoveSpeedScale(value);
}

set_gravity(value) { //e1877c95
	setDvar(#"bg_gravity", value);
}

third_person() { //ed855e11
	self.third_person = !return_toggle(self.third_person);
	if(self.third_person) {
		iPrintlnBold("Third Person [^2ON^7]");
		self setClientThirdPerson(1);
	} else {
		iPrintlnBold("Third Person [^1OFF^7]");
		self setClientThirdPerson(0);
	}
}

// Player Options

player_option(menu, player) { //a3b23e83
	if(!isDefined(menu) || !isDefined(player) || !isPlayer(player)) {
		menu = "Error";
	}

	switch (menu) {
		case "Player Option":
			self add_menu(clean_name(player get_name()));
			break;
		case "Error":
			self add_menu();
			self add_option("Oops, Something Went Wrong!", "Condition: Undefined");
			break;
		default:
			error = true;
			if(error) {
				self add_menu("Critical Error");
				self add_option("Oops, Something Went Wrong!", "Condition: Menu Index");
			}
			break;
	}
}

get_name() { //c91549ce
	name = self.name;
	if(name[0] != "[") {
		return name;
	}

	for(a = (name.size - 1); a >= 0; a--) {
		if(name[a] == "]") {
			break;
		}
	}

	return getSubStr(name, (a + 1));
}

clean_name(name) { //675b8c0
	if(!isDefined(name) || name == "") {
		return;
	}

	illegal = ["^A", "^B", "^F", "^H", "^I", "^0", "^1", "^2", "^3", "^4", "^5", "^6", "^7", "^8", "^9", "^:"];
	new_string = "";
	for(a = 0; a < name.size; a++) {
		if(a < (name.size - 1)) {
			if(array::contains(illegal, (name[a] + name[(a + 1)]))) {
				a += 2;
				if(a >= name.size) {
					break;
				}
			}
		}

		if(isDefined(name[a]) && a < name.size) {
			new_string += name[a];
		}
	}

	return new_string;
}

commit_suicide(target) { //d8a28e11
	target suicide();
}

print_name(target) { //c4da1a2b
	iPrintlnBold(target.name);
}

prod_settings(target) { //91f1d5e2
	iPrintln(target.bot.var_b2b8f0b6);
	iPrintln(target.bot.var_e8c941d6);
	iPrintln(target.var_abdff161);
}

kick_player(target) { //de512d61
	kick(target getEntityNumber());
}

// Killstreaks

give_killstreak(streak) { //ec07394f
	self killstreaks::give(streak, 1);
}

// Menu Options

modify_menu_position(offset, axis) { //e4288074
	if(axis == "x") {
		self.x_offset = 1220 + offset;
	} else {
		self.y_offset = 400 + offset;
	}
	scroll_cursor();
}

set_menu_rainbow() { //e709099e
	self.rainbow_enabled = true;
	self thread start_rainbow();
}

set_menu_colors(value, color) { //55638223
	self.rainbow_enabled = false;
	if(color == "Red") {
		self.menu_color_red = value;
		iPrintlnBold(color + " Changed to " + value);
	} else if(color == "Green") {
		self.menu_color_green = value;
		iPrintlnBold(color + " Changed to " + value);
	} else if(color == "Blue") {
		self.menu_color_blue = value;
		iPrintlnBold(color + " Changed to " + value);
	} else {
		iPrintlnBold(value + " | " + color);
	}
	self.menu_color = (self.menu_color_red / 255, self.menu_color_green / 255, self.menu_color_blue / 255);

	set_menu_color(self.menu_color);
}

hide_ui() { //a7e74c75
	self.hide_ui = !return_toggle(self.hide_ui);
	if(self.hide_ui) {
		self setClientUIVisibilityFlag("hud_visible", 0);
	} else {
		self setClientUIVisibilityFlag("hud_visible", 1);
	}
}

hide_weapon() { //6395585f
	self.hide_weapon = !return_toggle(self.hide_weapon);
	setDvar(#"cg_drawgun", !self.hide_weapon);
}

// Weapon Options

give_grenade(grenade) { //9270d7fd
	weapon = getWeapon(grenade);
	self giveWeapon(weapon);
	self giveMaxAmmo(weapon);
}

give_weapon(weapon) { //5be7a94b
	weapon = getWeapon(weapon);

	if(!self hasWeapon(weapon)) {
		self takeWeapon(self getCurrentWeapon());

		self giveWeapon(weapon);
		self switchToWeaponImmediate(weapon);

		wait 0.25;
		self giveStartAmmo(weapon);
	} else {
		self switchToWeaponImmediate(weapon);
	}
}

give_mastercraft_weapon(null, mastercraft_index, weapon, offset) { //72d8cec0
	current_weapon = self getCurrentWeapon();
	if(weapon == current_weapon.rootWeapon.name) {
		weapon = current_weapon;
	} else {
		weapon = getWeapon(weapon);
	}

	if(!isDefined(mastercraft_index)) {
		scroll_slider();
		mastercraft_index = (self.slider[(self.current_menu + "_" + (self.syn["cursor"].index))] + 1);
	}

	if(isDefined(offset) && isInt(offset)) {
		mastercraft_index += offset;
	}

	self.syn["mastercraft"][weapon.rootWeapon.name] = mastercraft_index;

	weapon_options = self calcWeaponOptions(0, 0, mastercraft_index);

	self takeWeapon(self getCurrentWeapon());

	self giveWeapon(weapon, weapon_options);
	self switchToWeaponImmediate(weapon);

	wait 0.25;
	self giveStartAmmo(weapon);
}

get_weapon_attachments() { //de099fee
	weapon = self getCurrentWeapon();

	retry_counter = 0;
	while(weapon == getWeapon(#"none")) {
		if(retry_counter < 100) {
			wait 0.1;
			weapon = self getCurrentWeapon();
			retry_counter++;
		} else {
			return;
		}
	}

	supported_attachments = weapon.supportedAttachments;

	blacklisted_attachments = ["none", "null", "clantag", "custom1", "custom2", "killcounter"];

	foreach(attachment in blacklisted_attachments) {
		if(isInArray(supported_attachments, attachment)) {
			supported_attachments = remove_from_array(supported_attachments, attachment);
		}
	}

	return supported_attachments;
}

get_equipped_attachments(weapon) { //b04978d6
	attachments = array();
	equipped = strTok(getWeaponName(weapon), "+");

	for (i = 1; i < equipped.size; i++) {
		attachments[attachments.size] = equipped[i];
	}

	return attachments;
}

equip_attachment(attachment, i) { //224c09c9
	weapon = self getCurrentWeapon();
	stock = self getWeaponAmmoStock(weapon);
	clip = self getWeaponAmmoClip(weapon);
	attachments = get_equipped_attachments(weapon);

	if(isArray(attachments)) {
		if(isInArray(attachments, attachment)) {
			attachments = remove_from_array(attachments, attachment);
		} else {
			optics = ["reflex", "elo", "mms", "holo", "acog", "dualoptic", "ir", "is"];
			if(isInArray(optics, attachment)) {
				foreach(optic in optics) {
					if(isInArray(attachments, optic)) {
						attachments = remove_from_array(attachments, optic);
					}
				}
			}

			attachments[attachments.size] = attachment;
		}
		weapon = getWeapon(weapon.rootWeapon.name, attachments);
	}

	camo_index = getCamoIndex(self getWeaponOptions(weapon));
	if(!isDefined(camo_index) || !isInt(camo_index)) {
		camo_index = 0;
	}

	mastercraft_index = 0;

	if(!isDefined(self.syn[weapon.rootWeapon.name])) {
		self.syn[weapon.rootWeapon.name] = array();
	}

	if(isDefined(self.syn["mastercraft"][weapon.rootWeapon.name])) {
		mastercraft_index = self.syn["mastercraft"][weapon.rootWeapon.name];
	}

	self.previous_weapon = self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());

	weapon_options = self calcWeaponOptions(camo_index, 0, mastercraft_index);

	self giveWeapon(weapon, weapon_options);

	self setWeaponAmmoStock(weapon, stock);
	self setWeaponAmmoClip(weapon, clip);
	self setSpawnWeapon(weapon, true);

	wait 0.1;

	weapon = self getCurrentWeapon();

	retry_counter = 0;
	while(weapon == getWeapon(#"none")) {
		if(retry_counter < 5) {
			wait 0.1;
			weapon = self getCurrentWeapon();
			retry_counter++;
		} else {
			self giveWeapon(self.previous_weapon);

			self setWeaponAmmoStock(weapon, stock);
			self setWeaponAmmoClip(weapon, clip);
			self setSpawnWeapon(weapon, true);

			wait 0.75;
			weapon = self getCurrentWeapon();
			break;
		}
	}

	self.syn["attachment_toggles"][i] = weaponHasAttachment(weapon, attachment);
}

equip_camo(camo_index) { //52f76807
	weapon = self getCurrentWeapon();
	self setCamo(weapon, camo_index);
}

take_weapon() { //5e8f396d
	self takeWeapon(self getCurrentWeapon());
	self switchToWeapon(self getWeaponsListPrimaries()[0]);
}

drop_weapon() { //84172a80
	self dropItem(self getCurrentWeapon());
}