#pragma transparent
#pragma body

// scenekit stashes time in scn_frame
float iTime = u_time/4; // scn_frame.time/2;

// grab uv coords from our material
float2 uv = _surface.diffuseTexcoord;

// we want a coords from -1 to 1 instead of standard uv coords (0-1)
float2 p = -1.0+2.0*uv;

//classic demo fx
float2 uvmod = float2(p.x, p.y);
 
// uv scroll it with time
uvmod += iTime;

// get the diffuse sampler and get col at distorted uv coords
float4 texcol = u_diffuseTexture.sample(u_diffuseTextureSampler, uvmod);
texcol[0] += sin(iTime + p.y) + cos(iTime + p.x*3);
texcol[1] -= cos(iTime + p.y*3) + sin(iTime + p.x);
texcol[2] += cos(iTime + p.y) - cos(iTime + p.x*3);
texcol[3] = 1;

_surface.diffuse = texcol;
