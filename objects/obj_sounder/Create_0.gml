//[GLOBAL]
if(!variable_global_exists("sounder_instance"))
{
	global.sounder_instance = id;
}
else
{
	instance_destroy(id);
	exit;
}
//audio_debug(true);

//[VARIABLES]
music_fade = 1;
music_previus_id = -1;
e = exp(2);

//[FUNCTIONS]
func_play_music = function(_snd, _fade)
{
	
}

func_play_sfx = function(_snd, _pitch = 1)
{
	//Normalize
	var _vol = (global.settings.sfx_vol / 100) * (global.settings.master_vol / 100);
	
	
	var _gain = (exp(_vol) - 1) / (e - 1);
	
	audio_play_sound(_snd, 200, false, _gain, 0, _pitch);
}
