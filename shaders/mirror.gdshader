shader_type spatial;
render_mode unshaded;

uniform sampler2D left_eye;
uniform sampler2D right_eye;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = vec2(-(SCREEN_UV.x - 1.0), -(SCREEN_UV.y - 1.0)) - EYE_OFFSET.xy;
	if (VIEW_INDEX == VIEW_MONO_LEFT){
		ALBEDO = texture(left_eye, uv).rgb;
	}else{
		ALBEDO = texture(right_eye, uv).rgb;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
