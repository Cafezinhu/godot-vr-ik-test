shader_type spatial;
render_mode unshaded;

uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = vec2(-(SCREEN_UV.x - 1.0), SCREEN_UV.y);
	ALBEDO = texture(tex, uv).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
