//[UPDATE ENTITY]
var _dt = delta_time / 1000000;
depth = 0;

if(!dying)
{
	image_xscale = 1;
	image_yscale = 1;
	
	shadow_inst.visible = true;
	
	if(func_isowner())
	{
		var _floor = func_placemetting(x, y, TileCollision.Floor);
		if(_floor != noone)
		{
			_floor.on_collide(id);
			frict = _floor.frict;
			event_user(0);
		}
		else
		{
			dying = true;
		}
		
		
	}

}
else
{
	depth = image_xscale < 0.5 ? 150 : 100;

	image_xscale -= 0.85 * _dt;
	image_yscale -= 0.85 * _dt;
	
	image_xscale = max(image_xscale, 0);
	image_yscale = max(image_yscale, 0);
	
	shadow_inst.visible = false;
	
	if(func_isowner())
	{
		vel_x = scr_math_smooth(vel_x, 0, 0.25);
		vel_y = scr_math_smooth(vel_y, 0, 0.25);
		
		if(image_xscale <= 0)
		{
			x = xstart;
			y = ystart;
			dying = false;
		}
	}

}



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
		if(func_placemetting(_x, y, TileCollision.Solid) != noone)
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
		if(func_placemetting(x, _y, TileCollision.Solid) != noone)
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

		var _packet = [net_id, x, y, vel_x, vel_y, sprite_index, image_index, visual_angle, image_blend, dying];

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
