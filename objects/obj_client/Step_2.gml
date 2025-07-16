// SEND DATA TO SERVER
if (array_length(outbox) > 0)
{
	var _buffer = buffer_create(1024, buffer_grow, 1);
	buffer_seek(_buffer, buffer_seek_start, 0);
	buffer_write(_buffer, buffer_u32, array_length(outbox));

	for (var _j = 0; _j < array_length(outbox); _j++)
	{
		var _msg = outbox[_j];
		var _opcode = _msg.opcode;
		var _args = _msg.args;

		buffer_write(_buffer, buffer_string, _opcode);

		var _entry = global.server_opcodes[? _opcode];
		var _types = _entry.parse;

		for (var _k = 0; _k < array_length(_args); _k++)
		{
			var _type = _types[_k];
			var _arg = _args[_k];

			if (_type == -1)
			{
				var _size = buffer_get_size(_arg);
				buffer_write(_buffer, buffer_u32, _size);

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
	network_send_packet(global.neat.socket, _compress, buffer_get_size(_compress));

	buffer_delete(_buffer);
	buffer_delete(_compress);

	outbox = [];
}
