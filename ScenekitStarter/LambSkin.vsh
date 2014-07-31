////////////////////////////////
////		 LAMBSKIN VS		////
////////////////////////////////

/*
	Adapted from:
	'lambSkin' shader from NVIDIA shader library
	http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html
	
	"A lambertian-like surface with light 'bleed-through'."
 */

attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform

uniform vec3 light_position;
uniform vec3 light_color;
// Varyings (to Fragment Shader)
varying vec3 LightVec, EyeNormal;
varying vec4 LightColor;


// LambSkin VS Function
void lambSkinVS(in vec4 V, in vec4 N)
{
    // Transform vertex into World space
    vec4 v = u_mv * V;
    // Set varyings
    LightVec = light_position- v.xyz;
    vec4 n = normalize(u_norm * N);
    EyeNormal = n.xyz;
}

void main()
{
    // Call LambSkin VS function
    lambSkinVS(a_srcPos,a_normPos);
    LightColor = vec4(light_color.r, light_color.g, light_color.b, 1.);
    //LightColor = vec4(0.,1.,0.,1.);
    // Transform vertex by projection matrix
    gl_Position = u_mvproj * a_srcPos;
    
    // Forward current color and texture coordinates after applying texture matrix
    gl_FrontColor = gl_Color;
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
