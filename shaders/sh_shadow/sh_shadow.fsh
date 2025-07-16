//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//[UNIFORMS]


//[MAIN]
void main()
{
	vec4 _tex = texture2D(gm_BaseTexture, v_vTexcoord);

	gl_FragColor = v_vColour;
	gl_FragColor.a *= _tex.a;

}
