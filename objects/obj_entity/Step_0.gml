//[UPDATE ENTITY]
var _dt = delta_time / 1000000;
if(func_isowner())
	event_user(0);



//[MOVE ENTITY]
sub_x += vel_x * _dt;
if(abs(sub_x) >= 1)
{
	var _mov = floor(abs(sub_x)) * sign(sub_x);
	var _abs = abs(_mov);
	
	sub_x -= _mov;
	
	var _steped = 0;
	
	for(var _i = 1;_i <= _abs;_i++)
	{
		var _x = x + (_i * sign(_mov));
		if(place_meeting(_x, y, obj_collision))
		{
			vel_x = 0;
			sub_x = 0;
			break;
		}
			
		_steped++;
	}
	
	x += (_steped * sign(_mov));
}

sub_y += vel_y * _dt;
if (abs(sub_y) >= 1)
{
	var _mov = floor(abs(sub_y)) * sign(sub_y);
	var _abs = abs(_mov);
	
	sub_y -= _mov;
	
	var _steped = 0;
	
	for (var _i = 1; _i <= _abs; _i++)
	{
		var _y = y + (_i * sign(_mov));
		if (place_meeting(x, _y, obj_collision))
		{
			vel_y = 0;
			sub_y = 0;
			break;
		}
		
		_steped++;
	}
	
	y += (_steped * sign(_mov));
}



if (func_isowner())
{
	event_user(1); // Post update
}

// Sync timer
if(global.neat.state != NetworkState.Noone)
{
	sync_timer -= _dt;
	if (sync_timer <= 0)
	{
		sync_timer += SYNC_RATE;

		var _packet = [net_id, x, y, vel_x, vel_y, sprite_index, image_index, visual_angle, image_blend];

		if (global.neat.state == NetworkState.Server)
		{
			// El servidor siempre puede sincronizar
			neat_send2_client("entity_sync", _packet, -1);
		}
		else if (func_isowner())
		{
			// El cliente solo puede sincronizar si es dueño
			neat_send2_server("entity_sync", _packet);
		}
	}
}
