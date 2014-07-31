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
 
    Adapted for SceneKit
    Dale Bradshaw 2014
    http://creative-workflow-hacks.com
    http://github.com/dalebradshaw
    twitter: @daleBradshaw
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
varying vec3 normal,lightDir, lightColor, eyeVec;

// GLSL version of HLSL builtin LIT function
vec3 lit (in float ndotl, in float ndoth, in float m)
{
    float ambient = 1.0;
    float diffuse = max(ndotl, 0.0);
    float specular = step(0.0,ndotl) * max(ndoth * m, 1.0);
    return vec3(ambient, diffuse, specular);
}

// Calculates specular dropoff
float glossy_drop(in float v, in float gMax, in float gMin, in float gDrop)
{
    return (gDrop+smoothstep(gMin,gMax,v)*(1.0-gDrop));
}

// Main Glossy Wet Hilight Fragment Shader function
vec4 glossyWetFS(in vec4 tex)
{
    // Normamlze varyings
    vec3 Ln = normalize(LightVec);
    vec3 Nn = normalize(EyeNormal);
    vec3 Vn = normalize(EyeView);
    vec3 Hn = normalize(Vn + Ln);
    // Specular component
    vec4 litV = vec4(lit(dot(Ln,Nn),dot(Hn,Nn),SpecularExponent),1.0);
    float spec = litV.y * litV.z;
    spec *= (Specularity * glossy_drop(spec,GlossMax,GlossMin,GlossDrop));
    vec4 SpecularContrib = spec * SpecularColor;
    // Diffuse component
    vec4 DiffuseContrib = litV.y * DiffuseColor + AmbientColor;
    // Combine lighting components and output result
    return SpecularContrib + (tex * DiffuseContrib);
}

// Texture input
uniform sampler2D Texture;

void main()
{
    vec4 texmap = texture2D(Texture, gl_TexCoord[0].xy);
    
    //Multiply color by texture
    gl_FragColor = glossyWetFS(texmap);
}

