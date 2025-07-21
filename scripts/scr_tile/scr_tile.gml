enum TileCollision 
{
	Solid,
	Trigger,
	Floor
}

function Tile(_x, _y) constructor
{
	//[VARIABLES]
	x_tile = _x;
	y_tile = _y;
	collision = TileCollision.Floor;
	frict = 0;
	
	
	//[FUNCTIONS]
	func_getneigths = function(_parent)
	{
		var _neigths_pos = 
		[
			[x_tile+0 , y_tile-1], //UP
			[x_tile+0 , y_tile+1], //DOWN
			[x_tile-1 , y_tile+0], //LEFT
			[x_tile+1 , y_tile+0], //RIGTH
		];
		
		var _neigths = [0 , 0 , 0 , 0];
		for(var _i = 0;_i < 4;_i++)
		{
			var _pos = _neigths_pos[_i];
			
			if(_pos[0] < 0 || _pos[0] >= MAP_SIZE)
				continue;
			
			if(_pos[1] < 0 || _pos[1] >= MAP_SIZE)
				continue;
				
			_neigths[_i] = _parent.func_getbuff(_pos[0], _pos[1]);
		}
		return _neigths;
	};
	
	on_create = function(_parent){};
	on_draw = function(_xd, _yd){};
	on_draw_shade = function(_xd, _yd){};
	
	is_colliding = function(_entity, _bbox)
	{
		return true;
	};
	on_collide = function(_entity){};
}



#region TILES
function TileGround(_x, _y) : Tile(_x, _y) constructor
{
	//[VARIABLES]
	frict = 2.5;
	frames = [4, 4 , 4, 4];
	
	
	//[OVERRIDE]
	on_create = function(_parent)
	{
		var _neigths = func_getneigths(_parent);
		
		//SPRITES
		if(_neigths[0] == 0) //TOP
		{
			if(_neigths[2] == 0) //L
			{
				frames[0] = 9;
				frames[1] = 0;
				frames[2] = 0;
				frames[3] = 4;
			}
			else if(_neigths[3] == 0) //R
			{
				frames[0] = 2;
				frames[1] = 9;
				frames[2] = 4;
				frames[3] = 2;
			}
			else
			{
				frames[0] = 1;
				frames[1] = 1;
				frames[2] = 4;
				frames[3] = 4;
			}
		}
		else if(_neigths[1] == 0) //BOTTOM
		{
			if(_neigths[2] == 0) //L
			{
				frames[0] = 6;
				frames[1] = 4;
				frames[2] = 9;
				frames[3] = 6;
			}
			else if(_neigths[3] == 0) //R
			{
				frames[0] = 4;
				frames[1] = 8;
				frames[2] = 8;
				frames[3] = 9;
			}
			else
			{
				frames[0] = 4;
				frames[1] = 4;
				frames[2] = 7;
				frames[3] = 7;
			}
		}
		else
		{
			if(_neigths[2] == 0) //L
			{
				frames[0] = 3;
				frames[1] = 4;
				frames[2] = 3;
				frames[3] = 4;
			}
			else if(_neigths[3] == 0) //R
			{
				frames[0] = 4;
				frames[1] = 5;
				frames[2] = 4;
				frames[3] = 5;
			}
		}

	}
	on_draw = function(_xd, _yd)
	{		
		draw_sprite(spr_tile_ground, frames[0], _xd + 0, _yd + 0);
		draw_sprite(spr_tile_ground, frames[1], _xd + 8, _yd + 0);
		draw_sprite(spr_tile_ground, frames[2], _xd + 0, _yd + 8);
		draw_sprite(spr_tile_ground, frames[3], _xd + 8, _yd + 8);

		

	}
	on_draw_shade = function(_xd, _yd)
	{
		draw_sprite_ext(spr_tile_ground, frames[0], _xd + 0, _yd + 0, 1, 1, 0, c_black, 0.85);
		draw_sprite_ext(spr_tile_ground, frames[1], _xd + 8, _yd + 0, 1, 1, 0, c_black, 0.85);
		draw_sprite_ext(spr_tile_ground, frames[2], _xd + 0, _yd + 8, 1, 1, 0, c_black, 0.85);
		draw_sprite_ext(spr_tile_ground, frames[3], _xd + 8, _yd + 8, 1, 1, 0, c_black, 0.85);
	}

	
	is_colliding = function(_entity, _bbox)
	{
		//GET POS
		var _x = (_bbox[0] + _bbox[2]) / 2;
		_x = floor(_x / 8);
		_x = clamp(_x, 0,1);
		
		var _y = (_bbox[1] + _bbox[3]) / 2;
		_y = floor(_y / 8);
		_y = clamp(_y, 0,1);
		
		//GET INDEX
		var _index = (_y * 2) + _x;

		
		return frames[_index] != 9;
	};
	on_collide = function(_entity)
	{

	}
}
function TileIce(_x, _y) : Tile(_x, _y) constructor
{
	//[VARIABLES]
	frict = 0.5;
	frames = [0 , 0 , 0, 0];
	collision = TileCollision.Floor;
	
	//[OVERRIDE]
	on_create = function(_parent)
	{
		var _neigths = func_getneigths(_parent);
		
		//SPRITES
		if(_neigths[0] == 1 && _neigths[2] == 1) //TOP - LEFT
		{
			frames[0] = 1;
		}
		if(_neigths[0] == 1 && _neigths[3] == 1) //TOP - RIGTH
		{
			frames[1] = 2;
		}
		if(_neigths[1] == 1 && _neigths[2] == 1) //BOTTOM - LEFT
		{
			frames[2] = 3;
		}
		if(_neigths[1] == 1 && _neigths[3] == 1) //BOTTOM - RIGTH
		{
			frames[3] = 4;
		}
	}
	on_draw = function(_xd, _yd)
	{
		draw_sprite(spr_tile_ice, frames[0] ,_xd+0, _yd+0);
		draw_sprite(spr_tile_ice, frames[1] ,_xd+8, _yd+0);
		draw_sprite(spr_tile_ice, frames[2] ,_xd+0, _yd+8);
		draw_sprite(spr_tile_ice, frames[3] ,_xd+8, _yd+8);
	}
	
	is_colliding = function(_entity, _bbox)
	{
		return true;
	};
	on_collide = function(_entity){}
}

#endregion