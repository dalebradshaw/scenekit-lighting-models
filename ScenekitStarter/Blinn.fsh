/////////////////////////////////////
////	   		BLINN FS			////
/////////////////////////////////////

/*
	Adpated from:
	http://www.lighthouse3d.com/opengl/glsl/index.php?pointlight
 */

// Varyings (from Vertex Shader)
varying vec3 normal, lightDir, lightColor;

//vec4 scene_color = vec4(0.,0.,0.,1.);
vec4 light_ambient = vec4(0.,0.,0.,1.);
vec4 light_diffuse = vec4(lightColor.r,lightColor.g,lightColor.b,1.);
vec4 light_specular = vec4(0.,0.,0.,1.);

vec4 material_ambient = vec4(0.,0.,0.,1.);
vec4 material_emission = vec4(0.,0.,0.,1.);
vec4 material_diffuse = vec4(1., 1., 1.,1.);

// Blinn Directional Fragment Shader
vec4 blinnDirectionalFS()
{
    vec4 scene_color = material_emission + material_ambient * light_ambient;
    // Ambient contribution
    vec4 final_color = (scene_color * material_ambient) + (light_ambient * material_ambient);
    vec3 N = normalize(normal);
    vec3 L = normalize(lightDir);
    float lambertTerm = dot(N,L);
    if(lambertTerm > 0.0) {
        // Diffuse contribution
       final_color += light_diffuse * material_diffuse * lambertTerm;
    }
    return final_color;
}

// Main Loop
void main (void)
{
    
    //gl_FragColor = testColor;
    gl_FragColor = blinnDirectionalFS();
}