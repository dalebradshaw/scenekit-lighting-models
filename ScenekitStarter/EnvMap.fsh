/////////////////////////////////////
////	    ENVIRONMENT MAP FS		////
/////////////////////////////////////

/*
	Adapted from:
	/Developer/Examples/Quartz Composer/Compositions/GLSL/Environment Map.qtz
 */

// Varyings (from Vertex Shader)
uniform sampler2D Environment;
uniform float Ratio;

varying vec4 outColor;

void main()
{
    vec2 tex = gl_TexCoord[1].xy;
    tex.y = 1.0 - tex.y;
    vec4 environmentColor = texture2D(Environment, tex);
    vec4 finalColor = mix(outColor, environmentColor, Ratio);
    gl_FragColor = finalColor;
}
