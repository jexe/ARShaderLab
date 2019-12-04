
// 1. Custom variable declarations (optional)
// For Metal, a pragma directive and one custom variable on each line:

#pragma arguments
float sphereRadius;

// For OpenGL, a separate uniform declaration for each custom variable
//uniform float intensity;

// 2. Custom global functions (optional)

//float2 sincos(float t) {
//    return float2(sin(t), cos(t));
//}

// 3. Pragma directives (optional)
#pragma transparent
#pragma body

// 4. Code snippet
float3 xyz = _geometry.position.xyz / sphereRadius;
_geometry.position.xyz += float3(sin(scn_frame.time + xyz[1]*2) * sphereRadius,
                            cos(scn_frame.time + xyz[2]*2) * sphereRadius,
                            sin(scn_frame.time + xyz[3]*2) * sphereRadius
                            ); 


