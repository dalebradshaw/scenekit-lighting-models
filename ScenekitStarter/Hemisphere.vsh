/////////////////////////////////////
////	       HEMISPHERE VS		////
/////////////////////////////////////

/*
	From the GLSL Orange Book
	Randi J. Rost
 */
attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform

uniform vec3 light_position;

// Varyings (to Fragment Shader)
uniform vec4 SkyColor;
uniform vec4 GroundColor;


// Hemisphere lighting Vertex Shader (no Fragment Shader required)
vec4 hemisphereVS(in vec4 v, in vec4 n)
{
    vec4 Nm = normalize(u_norm * n);
    vec3 N = Nm.xyz;
    vec3 V = vec3( u_mv* v);
    vec3 lightVec = normalize(light_position - V);
    float costheta = dot(N,lightVec);
    float a = 0.5 + 0.5 * costheta;
    return mix(GroundColor,SkyColor,a);
}
void main()
{
    gl_FrontColor = hemisphereVS(a_srcPos,a_normPos);
    gl_Position = u_mvproj * a_srcPos;
    // Forward texture coordinates after applying texture matrix
    //gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
