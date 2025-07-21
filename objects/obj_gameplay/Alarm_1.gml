if (corridors_2create == -1)
{
	corridors_2create = array_length(sectors);
}

// Get current and target room
var _origin = sectors[corridors_created];
var _target_index = (corridors_created + 1) % array_length(sectors);
var _target = sectors[_target_index];

// Get room centers
var _x = _origin[0];
var _y = _origin[1];

var _tx = _target[0];
var _ty = _target[1];

// Half size for centering corridor
var _half = floor(CORRIDOR_SIZE * 0.5);

// "Ant" walks from current to target, marking the path
while (_x != _tx || _y != _ty)
{
	// Fill corridor area centered on current position
	for (var dx = -_half; dx <= _half; dx++)
	for (var dy = -_half; dy <= _half; dy++)
	{
		func_setbuff(_x + dx, _y + dy, 0x01);
	}

	// Move towards target
	if (_x != _tx)
	{
		_x += sign(_tx - _x);
	}
	else if (_y != _ty)
	{
		_y += sign(_ty - _y);
	}
}

// Fill the last position
for (var dx = -_half; dx <= _half; dx++)
for (var dy = -_half; dy <= _half; dy++)
{
	func_setbuff(_x + dx, _y + dy, 0x01);
}

// Move to next corridor
corridors_created++;

// Continue or finish
if (corridors_created < corridors_2create)
{
	alarm[1] = 1; // Continue generating corridors
}
else
{
	alarm[2] = 1; // Done with corridor generation
}
