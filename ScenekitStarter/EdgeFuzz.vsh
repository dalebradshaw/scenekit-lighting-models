/////////////////////////////////////
////	   	   EDGE FUZZ VS		////
/////////////////////////////////////

/*
	Adapted from:
	NVIDIA Shader Library effect 'EdgeFuzz.fx'
	http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html
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
varying vec3 LightVec, EyeView, EyeNormal;

// Edge Fuzz Vertex Shader function
void edgefuzzVS(in vec4 V, in vec4 N)
{
    V = u_mv * V;
    vec3 v = vec3(V.xyz / V.w);
    LightVec = vec3(light_position.xyz - v.xyz);
    EyeView = normalize(vec3(0.0,0.0,2.0).xyz - v.xyz);
    vec4 n = u_norm * N;
    EyeNormal = n.xyz;
}

void main(void)
{

    edgefuzzVS(a_srcPos, a_normPos);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward texture coordinates after applying texture matrix
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}