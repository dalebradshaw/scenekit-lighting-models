attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform

// Varyings (to Fragment Shader)
//varying vec4
varying vec3 normal,lightDir, eyeVec;

vec3 light_position = vec3(0., 10., 10.);

// Phong Point Vertex Shader function
void phongVS(in vec4 vertex)
{
    vec3 V = vec3(vertex.xyz / vertex.w);
    lightDir = vec3(light_position.xyz - V.xyz);
    eyeVec = -V;
}

// Main Loop
void main()
{
    vec4 n = u_norm * a_normPos;
    normal = n.xyz;
    
    vec4 Vertex = u_mv * a_srcPos;
    
    phongVS(Vertex);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward texture coordinates after applying texture matrix
    //gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}