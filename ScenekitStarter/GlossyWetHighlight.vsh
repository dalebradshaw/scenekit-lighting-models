/////////////////////////////////////
////    GLOSSY WET HILIGHT VS	////
/////////////////////////////////////

/*
	Adapted from:
	'glossyWetHilight.fx' from NVIDIA shader library
	http://developer.download.nvidia.com/shaderlibrary/HLSL/glossyWetHilight.fx
	NDVIDIA Corporation 2007
	
	HLSL > GLSL conversion and Quartz Composer setup
	toneburst 2008
	http://machinesdontcare.wordpress.com
 */

// Varyings (to Fragment Shader)
varying vec3 LightVec, EyeView, EyeNormal;

// Tweakable parameter
uniform vec3 LightPosition;

// Main Glossy Wet Hilight Vertex Shader function
void glossyWetVS(in vec4 v, in vec3 n)
{
    LightVec = vec3(LightPosition.xyz - v.xyz);
    EyeView = normalize(gl_ProjectionMatrixInverse[3].xyz - v.xyz);
    EyeNormal = gl_NormalMatrix * n;
}

// Main Loop
void main()
{
    glossyWetVS(gl_Vertex,gl_Normal);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    
    //Forward current color and texture coordinates after applying texture matrix
    gl_FrontColor = gl_Color;
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
