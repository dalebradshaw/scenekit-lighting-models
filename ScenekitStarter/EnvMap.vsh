/////////////////////////////////////
////	    ENVIRONMENT MAP VS		////
/////////////////////////////////////

/*
	Adapted from:
	/Developer/Examples/Quartz Composer/Compositions/GLSL/Environment Map.qtz
	More environment maps can be found here
	http://www.codemonsters.de/home/content.php?show=spheremaps
 */

attribute vec4 a_srcPos;   // source position in the geometry
attribute vec4 a_normPos;   // normal position in the geometry
attribute vec2 a_texcoord; // texture coordinates in the geometry

uniform mat4 u_mv;    // ModelView transform
uniform mat4 u_proj;  // Projection transform
uniform mat4 u_mvproj; //ModelViewProjection
uniform mat4 u_norm; //Normal transform

uniform vec3 light_position;
// Tweakable parameters
uniform vec4 AmbientColor, DiffuseColor;


// Varyings (to Fragment Shader)
varying vec4 outColor;
varying vec2 texCoord;

void envMapVS(in vec4 V, in vec4 N)
{
    vec4 vWorld = u_mv * V;
    vec4 Nm = normalize(u_norm * N);
    vec3 nWorld = Nm.xyz;
    
    //texCoord = a_texcoord;
    
    // Diffuse
    vec3 vertToLight = normalize(light_position - vWorld.xyz);
    float diffuseLight = max(dot(vertToLight, nWorld), 0.0);
    outColor = AmbientColor + vec4(diffuseLight * DiffuseColor.xyz, DiffuseColor.w);

    // Environment mapping texture coordinates
    vec3 vWorldUnit = normalize(vWorld.xyz);
    vec3 f = reflect(vWorldUnit, nWorld);
    float m = 2.0 * sqrt(f.x*f.x + f.y*f.y + (f.z + 1.0)*(f.z + 1.0));
    texCoord.xy = vec2(f.x/m + .5, -f.y/m + .5);
}


void main()
{
    vec4 Vertex = a_srcPos;
    vec4 Normal = a_normPos;
    
    envMapVS(Vertex,Normal);

    //Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    //Forward texture coordinates after applying texture matrix
    //gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
