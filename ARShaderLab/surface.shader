#pragma transparent
#pragma body

// scenekit stashes time in scn_frame
float iTime = u_time/4; // scn_frame.time/2;

// grab uv coords from our material
float2 uv = _surface.diffuseTexcoord;

// we want a coords from -1 to 1 instead of standard uv coords (0-1)
float2 p = -1.0+2.0*uv;

// moving the texture
float2 uvmod = float2(p.x, p.y);
 
// uv scroll it with time
uvmod += iTime;

// get the diffuse sampler and get col at distorted uv coords

// Plasma
float4 texcol = u_diffuseTexture.sample(u_diffuseTextureSampler, uvmod);
texcol[0] += sin(iTime + p.y) + cos(iTime + p.x*3);
texcol[1] -= cos(iTime + p.y*3) + sin(iTime + p.x);
texcol[2] += cos(iTime + p.y) - cos(iTime + p.x*3);
texcol[3] = 1;

_surface.diffuse = texcol;

// Appearance
float aTime = u_time/2;
_surface.transparent = smoothstep(2 - aTime, 2 + 0.1 - aTime, p.y + sin(u_time + p.x*5)/4);
_surface.emission = 1 - smoothstep(2.2 - aTime, 2.2 + 0.1 - aTime, 0.3 + p.y + sin(u_time + p.x*5));
