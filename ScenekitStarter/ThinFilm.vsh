////////////////////////////////
////		THIN FILM VS		////
////////////////////////////////

/*
	Extracted and adapted from NVIDIA 'Thinfilm' demo
	ftp://download.nvidia.com/developer/SDK/Individual_Samples/3dgraphics_samples.html
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
uniform float FilmDepth;

// Varyings (to Fragment Shader)
varying vec3 diffColor, specColor;
varying vec2 viewDepth;

// Thinfilm VS function
void thinfilmVS(in vec4 V, in vec4 N)
{
    // Transform normal from model-space to view-space
    //vec4 n = u_norm * N;
    vec4 n = u_norm * N;
    vec3 normalVec = normalize(n.xyz);
    
    // Compute the eye->vertex vector
    const vec3 eyeVector = vec3(0.0,0.0,1.0);
    vec3 eyeVec = eyeVector;   // Infinite viewer (Best looking)
    
    // Compute the view depth for the thin film
    viewDepth = vec2((1.0 / dot(normalVec, eyeVec)) * FilmDepth);
    
    vec3 lightVec = normalize(light_position);
    
    // Calculate half-angle vector
    vec3 halfAngleVec = normalize(lightVec + eyeVec);
    
    // Calculate diffuse component
    float diffuse = max(dot(normalVec, lightVec), 0.0);
    
    // Calculate specular component
    float specular = max(dot(normalVec, halfAngleVec), 0.0);
    specular = pow(specular, 32.0);
    
    // Output final lighting results
    diffColor = vec3(diffuse);
    specColor = vec3(specular);
}

// Main Loop
void main()
{
    thinfilmVS(a_srcPos,a_normPos);
    
    // Transform vertex by modelview and projection matrices
    gl_Position = u_mvproj * a_srcPos;
    
    // Forward texture coordinates after applying texture matrix
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}