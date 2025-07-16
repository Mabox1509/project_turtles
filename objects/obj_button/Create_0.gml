//[VARIABLES]
mouse_over = false;
parent = noone;

//[FUNCTIONS]
func_parent = function(_parent)
{
	if (_parent.object_index != obj_rect)
		return;

	// Si ya tenemos un padre
	if (parent != noone)
	{
		// Quitarnos de su lista de hijos
		var _index = array_get_index(parent.childs, id);
		if (_index != -1)
		{
			array_delete(parent.childs, _index, 1);
		}
	}

	// Establecer nuevo padre
	parent = _parent;

	// Asegurarse de que el nuevo padre tiene lista de hijos
	if (!variable_instance_exists(parent, "childs"))
	{
		parent.childs = [];
	}

	// Añadirnos a la lista de hijos del nuevo padre
	array_push(parent.childs, id);
};


on_click = function()
{
	
}
on_over = function(_x, _y){}


//DEFAULT RECT
if(!variable_global_exists("default_rect"))
{
	global.default_rect = instance_create_depth(0, 0,  0, obj_rect);
	global.default_rect.func_resize(192, 192);
	global.default_rect.persistent = true;
}

func_parent(global.default_rect);