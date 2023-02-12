shader_type canvas_item;
// Create a variable to store background color
const vec4 backgroundColour = vec4(0.2, .9, .9, 1.0);
const vec4 foregroundColor = vec4(.90, .99, 1.0, 1.0);
const vec4 whiteColor = vec4(1.0);


//void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
void fragment()
{
    // Normalize the fragment coordinates to a value between 0 and 1
    vec2 uv = UV;
    
    // Offset the UV coordinates based on time
    uv.x += (TIME * 0.2); // Horizontally moves the grid along x-axis with time
    uv.y += sin(TIME * 0.1); // Vertically moves the grid along y-axis with time, using sine wave

    // Create a grid pattern based on the modified UV coordinates
    vec2 gridSize = uv * 4.0;
    vec2 grid = fract( gridSize );
    
    float random = fract(sin(dot(floor(gridSize),vec2(12.9898,78.233))) * 43758.5453);
    
    // Output the final color by blending the grid lines (white) and the background (blue)
    float blender = smoothstep( random, clamp( sin(TIME), 0.3, 0.8), 0.4 );
    COLOR = mix( whiteColor, mix(foregroundColor, backgroundColour, blender), step(0.04, grid.x) * step(0.04, grid.y) );
}