/////////////////////////////////////
////	   	   EDGE FUZZ FS		////
/////////////////////////////////////

/*
	Adapted from:
	NVIDIA Shader Library effect 'EdgeFuzz.fx'
 */


// Tweakable controls
uniform float Specularity;
uniform float Fuzziness;
uniform vec4 EdgeColor;
uniform vec4 SurfaceColor;
uniform float EdgeFade;
uniform vec4 LightColor;
uniform vec4 AmbientColor;
vec4 SpecularColor = vec4(1.0,1.0,1.0,1.0);

// Varyings (from Vertex Shader)
varying vec3 LightVec, EyeView, EyeNormal;

// GLSL version of HLSL builtin lit function
vec3 lit (in float ndotl, in float ndoth, in float m)
{
    float ambient = 1.0;
    float diffuse = max(ndotl, 0.0);
    float specular = step(0.0,ndotl) * max(ndoth * m, 1.0);
    return vec3(ambient, diffuse, specular);
}

// Edge Fuzz Fragment Shader function
vec4 edgefuzzFS()
{
    vec3 Ln = normalize(LightVec);
    vec3 Vn = normalize(EyeView);
    vec3 Nn = normalize(EyeNormal);
    vec3 Hn = normalize(Vn + Ln);
    float ldn = dot(Ln,Nn);
    vec4 lv = vec4(lit(ldn,dot(Hn,Nn),Specularity),1.0);
    float subd = abs(dot(Nn,Vn));
    subd = pow(subd,Fuzziness);
    vec3 SurfColor = mix(EdgeColor.rgb,SurfaceColor.rgb,subd);
    SurfColor = mix(SurfaceColor.rgb,SurfColor,EdgeFade);
    ldn = max(ldn,0.0);
    ldn = pow(ldn,Fuzziness);
    vec3 IncidentColor = mix(EdgeColor.rgb,LightColor.rgb,ldn);
    IncidentColor = mix(LightColor.rgb,IncidentColor,ldn);
    vec3 diffContrib = SurfColor * (lv.y*IncidentColor + AmbientColor.rgb);
    vec3 specContrib = SpecularColor.rgb * lv.y * lv.z * IncidentColor;
    
    return vec4(diffContrib+specContrib,1.0);
}


// Main Function
void main (void)
{
    gl_FragColor = edgefuzzFS();
}