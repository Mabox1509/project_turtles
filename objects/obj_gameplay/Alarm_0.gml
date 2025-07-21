//DEFINE ROOMS SIZE
var _xsector = floor(random_range(5, MAP_SIZE-5));
var _ysector = floor(random_range(5, MAP_SIZE-5));

var _w = round(random_range(1, 4));
var _h = round(random_range(1, 3));

//------------------------------------
// CHECK IF IS COLLIDING WITH OTHER ROOM
//------------------------------------
var _collision = false;

for (var i = 0; i < array_length(sectors); i++)
{
	var _r = sectors[i];
	
	var _rx = _r[0];
	var _ry = _r[1];
	var _rw = _r[2]+1;
	var _rh = _r[3]+1;
	
	// AABB overlap check
	if (
		_xsector + _w >= _rx - _rw &&
		_xsector - _w <= _rx + _rw &&
		_ysector + _h >= _ry - _rh &&
		_ysector - _h <= _ry + _rh
	) {
		_collision = true;
		break;
	}
}

if (_collision)
{
	// Retry next frame without placing or counting this room
	sectors_fail++;
	if(sectors_fail > 128)
	{
		alarm[1] = 1;
	}
	else
	{
		alarm[0] = 1;
	}
	
	
	exit;
}

//------------------------------------
// FILL ROOM (write to buffer)
//------------------------------------
for (var _i = -_w; _i <= _w; _i++)
{
	var _x = _xsector + _i;
	if (_x < 1 || _x >= MAP_SIZE-1) continue;

	for (var _j = -_h; _j <= _h; _j++)
	{
		var _y = _ysector + _j;
		if (_y < 1 || _y >= MAP_SIZE-1) continue;

		func_setbuff(_x, _y, 0x01);
	}
}

//------------------------------------
// REGISTER ROOM
//------------------------------------
sectors_created++;
array_push(sectors, [_xsector, _ysector, _w, _h]);

//------------------------------------
// CONTINUE GENERATION
//------------------------------------
if (sectors_2create > sectors_created)
{
	alarm[0] = 1;
}
else
{
	alarm[1] = 1;
}
