if(async_load[? "id"] != global.neat.socket)
exit;

var _id = async_load[? "id"];
var _socket = async_load[? "socket"];



switch(async_load[? "type"])
{
	
	case network_type_data:
		var _buffer = async_load[? "buffer"];
		
		//var _raw_size = buffer_get_size(_buffer);
		var _decompressed = buffer_decompress(_buffer);
		
		buffer_seek(_decompressed, buffer_seek_start, 0);
		
		neat_handler(_decompressed);

		buffer_delete(_decompressed);
	break;
}
