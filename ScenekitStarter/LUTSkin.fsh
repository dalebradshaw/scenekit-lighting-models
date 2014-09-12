////////////////////////////////
////		 LUTSKIN FS		////
////////////////////////////////

/*
	Subsurface scattering approximation
	Adapted from GPU Gems Vol.1
	Chapter 16. 'Real-Time Approximations to Subsurface Scattering'
	by Simon Green
	
	Available online at
	http://http.developer.nvidia.com/GPUGems/gpugems_ch16.html
 */

// Varyings (to Fragment Shader)
varying vec3 Normal, LightVec, HalfVec;
// Tweakable parameters
uniform vec4 DiffuseColor, SpecularColor;
// Lookup table
uniform sampler2D SkinLUT;

// Skin LUT Fragment Shader function
vec4 skinLUT_FS()
{
    vec2 s;
    s.x = dot(Normal,LightVec);
    s.y = dot(Normal,HalfVec);
    s = s * 0.5 + 0.5;
    s.x = min(0.996,s.x);
    vec4 light = texture2D(SkinLUT, s);
    return DiffuseColor * light + SpecularColor * light.a;
}

// Main Loop
void main()
{
    gl_FragColor = skinLUT_FS();
    //gl_FragColor = SpecularColor * light.a;
}
