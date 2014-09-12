////////////////////////////////
////		 LUTSKIN VS		////
////////////////////////////////

/*
	Subsurface scattering approximation
	Adapted from GPU Gems Vol.1
	Chapter 16. 'Real-Time Approximations to Subsurface Scattering'
	by Simon Green
	
	Available online at
	http://http.developer.nvidia.com/GPUGems/gpugems_ch16.html
 */


attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform

uniform vec3 light_color;
uniform vec3 light_position;


// Varyings (to Fragment Shader)
//varying vec4
varying vec3 Normal, lightDir, lightColor, eyeVec, LightVec, HalfVec;



// Skin LUT Vertex Shader function
void skinLUT_VS(in vec4 v, in vec4 n)
{
    v = u_mv * v;
    vec3 V = v.xyz / v.w;
    vec4 nm = normalize(u_norm * n);
    Normal = nm.xyz;
    LightVec = normalize(light_position - V.xyz);
    const vec3 eye = vec3(0.0,0.0,1.0);
    HalfVec = normalize(LightVec + eye);
}
// Main Loop
void main()
{
    vec4 n = u_norm * a_normPos;

    
    lightColor = light_color;
    vec4 Vertex = u_mv * a_srcPos;
    
    skinLUT_VS(Vertex, n);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward texture coordinates after applying texture matrix
    //gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}