// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_math_towards(_a,_b,_speed)
{
	var _dist = abs(_a-_b);
	if(_dist < _speed)
	{
		return _b;
	}
	else
	{
		var _dir = _a > _b ? -1 : 1;
		return _a + (_speed * _dir);
	}
}

function scr_math_smooth(_a,_b,_time)
{
	if(_time > 0)
	{
		var _dist = abs(_b - _a);
		var _speed = (_dist / _time);
	
		var _dt = delta_time / 1000000;
	
		return scr_math_towards(_a,_b,_speed * _dt);
	}
	else
	{
		return _b;
	}
}



function scr_math_towards_angle(_a, _b, _speed)
{
	_a = _a % 360;
	_b = _b % 360;
	
	var _diff = _b - _a;
	_diff += _diff>180? -360 : (_diff<-180 ? 360 : 0);
	
	var _interpolation = sign(_diff)*min(abs(_diff), abs(_speed));
	return(360 + _a + _interpolation) % 360;
}
function scr_math_smooth_angle(_a, _b, _time)
{
    _a = _a % 360;
    _b = _b % 360;
    
    if (_time > 0)
    {
        var _diff = _b - _a;
        _diff += _diff > 180 ? -360 : (_diff < -180 ? 360 : 0);
        
	var _dt = delta_time / 1000000;
	
        var _speed = (abs(_diff) / _time);
        var _interpolation = sign(_diff) * min(abs(_diff), _speed * _dt);
        
        return (360 + _a + _interpolation) % 360;
    }
    else
    {
        return _b;
    }
}