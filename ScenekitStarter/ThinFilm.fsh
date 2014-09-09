////////////////////////////////
////		THIN FILM FS		////
////////////////////////////////

/*
	Extracted and adapted from NVIDIA 'Thinfilm' demo
	ftp://download.nvidia.com/developer/SDK/Individual_Samples/3dgraphics_samples.html
 */

// Texture maps
uniform sampler2D DiffuseMap;
uniform sampler2D FringeMap;

// Varyings (from Vertex Shader)
varying vec3 diffColor, specColor;
varying vec2 viewDepth;

// Thinfilm FS function
vec4 thinfilmFS()
{
    // Diffuse material color
    vec3 diffMaterial = texture2D(DiffuseMap,  gl_TexCoord[0].xy).rgb;
    diffMaterial  = vec3(0.125,0.125,0.125);

    // Lookup fringe value based on view depth
    vec3 fringeColor = texture2D(FringeMap, viewDepth).rgb;
    
    // modulate specular lighting by fringe color, combine with regular lighting
    return vec4(diffColor*diffMaterial + fringeColor*specColor, 1.0);
}

// Main Loop
void main()
{
   gl_FragColor = thinfilmFS();
}