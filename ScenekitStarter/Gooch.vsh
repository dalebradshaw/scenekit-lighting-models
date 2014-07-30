/////////////////////////////////////
////	   		GOOCH VS			////
/////////////////////////////////////

/*
	Adapted from:
	Vertex shader for Gooch shading
	Author: Randi Rost
	Copyright (c) 2002-2006 3Dlabs Inc. Ltd.
	See 3Dlabs-License.txt for license information
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
varying float NdotL;
varying vec3  ReflectVec;
varying vec3  ViewVec;


// Gooch Vertex Shader function
void goochVS(in vec4 V)
{
    vec3 v = vec3(V.xyz / V.w);
    vec4 n = normalize(u_norm * a_normPos);
    vec3 tnorm = n.xyz;
    vec3 lightVec = normalize(light_position - v);
    ReflectVec = normalize(reflect(-lightVec, tnorm));
    ViewVec = normalize(-v);
    NdotL = (dot(lightVec, tnorm) + 1.0) * 0.5;
}

void main(void)
{
    vec4 Vertex = u_mv * a_srcPos;
    goochVS(Vertex);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward texture coordinates after applying texture matrix
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}