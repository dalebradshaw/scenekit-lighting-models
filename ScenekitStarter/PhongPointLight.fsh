/////////////////////////////////////
////	      PHONG POINT FS		////
/////////////////////////////////////

/*
	Apapted from:
	http://www.ozone3d.net/tutorials/glsl_lighting_phong_p3.php
 */

// Varyings (from Vertex Shader)
varying vec3 normal,lightDir, lightColor, eyeVec;

//vec4 scene_color = vec4(0.,0.,0.,1.);
vec4 light_ambient = vec4(0.,0.,0.,1.);
vec4 light_diffuse = vec4(lightColor.r,lightColor.g,lightColor.b,1.);
vec4 light_specular = vec4(0.,0.,0.,1.);

vec4 material_ambient = vec4(0.,0.,0.,1.);
vec4 material_emission = vec4(0.,0.,0.,1.);
vec4 material_diffuse = vec4(1., 1., 1.,1.);
float material_specular = 1.;
float shininess = 10.35;

// Phong Point function
vec4 phongPointFS()
{
    vec4 scene_color = material_emission + material_ambient * light_ambient;
    // Ambient contribution
    vec4 final_color = (scene_color * material_ambient) + (light_ambient * material_ambient);
    vec3 N = normalize(normal);
    vec3 L = normalize(lightDir);
    float lambertTerm = dot(N,L);
    
    if(lambertTerm > 0.0)
    {
        // Diffuse contribution
        final_color += light_diffuse * material_diffuse * lambertTerm;
        // Specular contribution
        vec3 E = normalize(eyeVec);
        vec3 R = reflect(-L, N);
        float specular = pow(max(dot(R, E), 0.0), shininess);
        final_color += light_specular
        * material_specular * specular;
    }
    
    return final_color;
}

// Main Loop
void main (void)
{
    
    //gl_FragColor = testColor;
    gl_FragColor = phongPointFS();
    
}