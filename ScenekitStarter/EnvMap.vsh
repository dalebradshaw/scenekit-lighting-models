/////////////////////////////////////
////	    ENVIRONMENT MAP VS		////
/////////////////////////////////////

/*
	Adapted from:
	/Developer/Examples/Quartz Composer/Compositions/GLSL/Environment Map.qtz
	More environment maps can be found here
	http://www.codemonsters.de/home/content.php?show=spheremaps
 */

// Tweakable parameters
uniform vec4 AmbientColor, DiffuseColor;
uniform vec3 LightPosition;

// Varyings (to Fragment Shader)
varying vec4 outColor;

void envMapVS(in vec4 V, in vec3 N)
{
    vec4 vWorld = gl_ModelViewMatrix * V;
    vec3 nWorld = gl_NormalMatrix * N;
    
    // Diffuse
    vec3 vertToLight = normalize(LightPosition - vWorld.xyz);
    float diffuseLight = max(dot(vertToLight, nWorld), 0.0);
    outColor = AmbientColor + vec4(diffuseLight * DiffuseColor.xyz, DiffuseColor.w);
    
    // Environment mapping texture coordinates
    vec3 vWorldUnit = normalize(vWorld.xyz);
    vec3 f = reflect(vWorldUnit, nWorld);
    float m = 2.0 * sqrt(f.x*f.x + f.y*f.y + (f.z + 1.0)*(f.z + 1.0));
    gl_TexCoord[1].xy = vec2(f.x/m + .5, -f.y/m + .5);
}


void main()
{
    vec4 Vertex = gl_Vertex;
    vec3 Normal = gl_Normal;
    
    envMapVS(Vertex,Normal);
    
    //Transform vertex by modelview and projection matrices
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
    
    //Forward texture coordinates after applying texture matrix
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
