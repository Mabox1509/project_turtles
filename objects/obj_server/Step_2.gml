// SEND DATA TO CLIENTS
var _clients = ds_map_keys_to_array(clients);

for (var _i = 0; _i < array_length(_clients); _i++)
{
	var _id = _clients[_i];
	var _client = clients[? _id];

	if (array_length(_client.outbox) > 0)
	{		
		var _buffer = buffer_create(1024, buffer_grow, 1);
		buffer_seek(_buffer, buffer_seek_start, 0);
		buffer_write(_buffer, buffer_u32, array_length(_client.outbox));

		for (var _j = 0; _j < array_length(_client.outbox); _j++)
		{
			var _msg = _client.outbox[_j];
			var _opcode = _msg.opcode;
			var _args = _msg.args;

			buffer_write(_buffer, buffer_string, _opcode);

			var _entry = global.client_opcodes[? _opcode];
			var _types = _entry.parse;

			for (var _k = 0; _k < array_length(_args); _k++)
			{
				var _type = _types[_k];
				var _arg = _args[_k];

				if (_type == -1)
				{
					var _size = buffer_get_size(_arg);
					buffer_write(_buffer, buffer_u32, _size); // Escribe el tamaño

					for (var _b = 0; _b < _size; _b++)
					{
						var _byte = buffer_peek(_arg, _b, buffer_u8);
						buffer_write(_buffer, buffer_u8, _byte);
					}

					buffer_delete(_arg);
				}
				else
				{
					buffer_write(_buffer, _type, _arg);
				}
			}
		}

		var _compress = buffer_compress(_buffer, 0, buffer_get_size(_buffer));
		network_send_packet(_id, _compress, buffer_get_size(_compress));
		
		
		buffer_delete(_buffer);
		buffer_delete(_compress);

		_client.outbox = [];
	}
}
