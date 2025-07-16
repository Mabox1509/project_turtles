//
// Fragment shader con lens distortion
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//[UNIFORMS]
uniform float time;
uniform float resolution;

//[CONST]
const float texel = 0.005208333;


//[FUNCTIONS]


//[MAIN]
void main()
{
	//[UV]
	vec2 _uv = v_vTexcoord;
	_uv.x = floor(_uv.x / texel) * texel;
	_uv.y = floor(_uv.y / texel) * texel;
	
	_uv.x += sin((_uv.y * 5.0) + (time * 0.5) )  * (1.0 * texel);
	//_uv.y += sin((_uv.y * 15.0) + (time * 0.5) )  * (1.0 * texel);
	
	//[OUT]
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, _uv);
}
