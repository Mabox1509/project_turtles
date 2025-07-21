global.settings = 
{
	lang : "esp",
	
	master_vol : 100,
	bgm_vol : 65,
	sfx_vol : 75
};


function settings_load()
{
	var _path = game_save_id + "settings.ini";
	
	if(file_exists(_path))
	{
		ini_open(_path);
		
		global.settings.lang = ini_read_string("GENERAL", "language", "esp");
		
		global.settings.master_vol = ini_read_real("VOLUME", "master", 100);
		global.settings.bgm_vol = ini_read_real("VOLUME", "music", 65);
		global.settings.sfx_vol = ini_read_real("VOLUME", "effects", 75);
		
		ini_close();
	}
	else
	{
		settings_save();
	}
}

function settings_save()
{
	var _path = game_save_id + "settings.ini";
	
	ini_open(_path);
	
	// Guardar idioma
	ini_write_string("GENERAL", "language", global.settings.lang);

	// Guardar volumen
	ini_write_real("VOLUME", "master", global.settings.master_vol);
	ini_write_real("VOLUME", "music", global.settings.bgm_vol);
	ini_write_real("VOLUME", "effects", global.settings.sfx_vol);
	
	ini_close();
}
