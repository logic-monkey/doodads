shader_type canvas_item;
render_mode blend_mix;
uniform vec3 color_to_mix : source_color;
uniform float mix_amount;


void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	COLOR.a = tex.a;
	COLOR.rgb = mix(COLOR.rgb, color_to_mix.rgb, mix_amount);
	
}
