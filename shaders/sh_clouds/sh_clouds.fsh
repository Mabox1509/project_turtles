//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//[UNIFORMS]
uniform float time;

//[MAIN]
void main()
{
	//[UV]
	vec2 _uv = v_vTexcoord;
	_uv.x += sin((time * 0.5) + (_uv.y * 8.0)) * 0.05;
	
	_uv.x = mod(_uv.x, 1.0);
	
	//[OUT]
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, _uv );
}
