shader_type canvas_item;

uniform float cut_off: hint_range(0.0, 1.0) = 0.5;
uniform float feather: hint_range(0.0, 1.0) = 0.1;

void fragment()
{
	vec4 col = vec4(0.0, 0.0, 0.0, 1.0);
	col.a = smoothstep(cut_off - feather, cut_off, UV.x * (1.0 - feather));
	COLOR = col;
}