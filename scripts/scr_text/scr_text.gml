global.texts = ds_map_create();

function load_language(_lang)
{
	//Clear map
	ds_map_clear(global.texts);
	
	//Get path
	var _path = "langs/" + _lang + ".json";
	if(!file_exists(_path))
		throw "Lang file not found";
	
	//Load data
	var _buffer = buffer_load(_path);
	var _string = buffer_peek(_buffer, 0, buffer_string);
	buffer_delete(_buffer);
	
	//Read data
	var _json = json_parse(_string);
	var _keys = struct_get_names(_json);
	for(var _i = 0;_i < array_length(_keys);_i++)
	{
		global.texts[? _keys[_i]] = variable_struct_get(_json, _keys[_i]);
	}
}

function scr_text(_key)
{
	if(!ds_map_exists(global.texts, _key))
		return _key;
		
	return global.texts[? _key];
}


//[INITIALIZE]
load_language("esp");