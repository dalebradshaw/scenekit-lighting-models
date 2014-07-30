/////////////////////////////////////
////	     VELVET SHADER VS		////
/////////////////////////////////////

/*
	Translated from HLSL shader for VVVV
	vNoiseVelvety.fx
	by Desaxismundi 2008
	
	Velvet shader originally by NVIDIA
	
	GLSL conversion toneburst 2008
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
uniform vec4 PrimaryColor;	// Diffuse
uniform vec4 FuzzColor;		// Specular
uniform vec4 UnderColor;	// SubColor
uniform float Rolloff;		// Edge-rolloff

// Velvet Vertex Shader function
vec4 VelvetyVS(in vec4 V, in vec4 N)
{
    // Transform normal into Eye Space
    vec4 Nm = normalize(u_norm * N);
    vec3 Nn = Nm.xyz;
    // Transform vertex into Eye Space
    vec4 Po = V;
    vec3 Pe = (u_mv * Po).xyz;
    vec3 Ln = normalize(light_position - Pe);
    float ldn = dot(Ln,Nn);
    float diffComp = max(0.0,ldn);
    vec4 diffContrib = diffComp * PrimaryColor;
    float subLamb = smoothstep(-Rolloff,1.0,ldn) - smoothstep(0.0,1.0,ldn);
    subLamb = max(0.0,subLamb);
    vec4 subContrib = subLamb * UnderColor;
    vec3 cameraPos = vec3(0.0,0.0,1.0);
    vec3 Vn = normalize(cameraPos - Pe);
    float vdn = 1.0-dot(Vn,Nn);
    vec4 vecColor = vec4(vdn,vdn,vdn,1.0);
    vec4 DiffColor = subContrib + diffContrib;
    vec4 SpecColor = vecColor * FuzzColor;
    
    return DiffColor + SpecColor;
}

void main()
{
    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward current color and texture coordinates after applying texture matrix
    gl_FrontColor = VelvetyVS(a_srcPos, a_normPos);
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
