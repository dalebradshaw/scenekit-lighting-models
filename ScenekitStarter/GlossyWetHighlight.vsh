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
attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform
uniform mat4 u_inverseProjectionTransform;//inverse projection

uniform vec3 light_color;
uniform vec3 light_position;

// Varyings (to Fragment Shader)
varying vec3 LightVec, EyeView, EyeNormal;

// Tweakable parameter
uniform vec3 LightPosition;

// Main Glossy Wet Hilight Vertex Shader function
void glossyWetVS(in vec4 V, in vec4 N)
{
    LightVec = vec3(light_position.xyz - V.xyz);

    EyeView = normalize(u_inverseProjectionTransform[3].xyz-V.xyz);
    vec4 n = normalize(u_norm * N);
    EyeNormal = n.xyz;
}

// Main Loop
void main()
{
    glossyWetVS(a_srcPos,a_normPos);
    
    //Transform vertex by modelview and projection matrices
    gl_Position =  u_mvproj * a_srcPos;
    
    //Forward current color and texture coordinates after applying texture matrix
    gl_FrontColor = gl_Color;
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
