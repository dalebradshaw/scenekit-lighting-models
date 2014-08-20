/////////////////////////////////////
////	   		GOOCH FS			////
/////////////////////////////////////

/*
	Adapted from:
	Vertex shader for Gooch shading
	Author: Randi Rost
	Copyright (c) 2002-2006 3Dlabs Inc. Ltd.
	See 3Dlabs-License.txt for license information
 */

// Tweakable controls
uniform vec4  SurfaceColor;
uniform vec4  WarmColor;
uniform vec4  CoolColor;
uniform float DiffuseWarm;
uniform float DiffuseCool;
// Varyings (from Vertex Shader)
varying float NdotL;
varying vec3  ReflectVec;
varying vec3  ViewVec;

// Gooch Fragment Shader function
vec4 goochFS()
{
    vec3 kcool = min(CoolColor.rgb + DiffuseCool * SurfaceColor.rgb, 1.0);
    vec3 kwarm = min(WarmColor.rgb + DiffuseWarm * SurfaceColor.rgb, 1.0);
    vec3 kfinal = mix(kcool, kwarm, NdotL);
    
    vec3 nreflect = normalize(ReflectVec);
    vec3 nview = normalize(ViewVec);
    
    float spec = max(dot(nreflect, nview), 0.0);
    spec = pow(spec, 32.0);
    
    return vec4(min(kfinal + spec, 1.0), 1.0);
    
}

// Main Function
void main (void)
{
    gl_FragColor = goochFS();
}