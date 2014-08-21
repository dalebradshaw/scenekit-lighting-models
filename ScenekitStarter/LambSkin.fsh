////////////////////////////////
////		 LAMBSKIN FS		////
////////////////////////////////

/*
	Adapted from:
	'lambSkin' shader from NVIDIA shader library
	http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html
	
	"A lambertian-like surface with light 'bleed-through'."
 */
// Tweakable controls
uniform vec4 AmbientColor;
uniform vec4 DiffuseColor;
uniform vec4 SubColor;
uniform float Rolloff;
// Varyings (from Vertex Shader)
varying vec3 LightVec, EyeNormal;
varying vec4 LightColor;

// LambSkin FS function
vec4 lambSkin()
{
    // Normalize normal and light vector
    vec3 Ln = normalize(LightVec);
    vec3 Nn = normalize(EyeNormal);
    
    float ldn = dot(Ln,Nn);
    
    // Calculate diffuse contribution
    float diffComp = max(0.0,ldn);
    vec4 Diffuse = vec4((diffComp * DiffuseColor).xyz,1.0);
    
    // Calculate simulated subsurface contribution
    float subLamb = smoothstep(-Rolloff,1.0,ldn) - smoothstep(0.0,1.0,ldn);
    subLamb = max(0.0,subLamb);
    vec4 Subsurface = subLamb * SubColor;
    //vec4 Subsurface = subLamb * vec4(1.,0.,0.,1.);
    // Output
    return Diffuse + AmbientColor + Subsurface;
}

// Main Loop
void main()
{
    //gl_FragColor = lambSkin() * texture2D(Texture, gl_TexCoord[0].xy);
    gl_FragColor = lambSkin();
}