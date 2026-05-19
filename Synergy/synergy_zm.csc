#include scripts\core_common\system_shared;

#namespace synergy_zm;

autoexec __init__sytem__() { //607fee8
	system::register("synergy_zm", &init, undefined, undefined);
}

init() { //9284135d
	level waittill("show_narrative_dotn");
	player = getlocalplayers()[0];
	localclientnum = player getlocalclientnumber();
	
  function_a5777754(localclientnum, "narrative_room");
}