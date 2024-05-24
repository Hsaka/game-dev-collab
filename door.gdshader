shader_type spatial;
const float malfunction = 1.0;
uniform float randomness = 0.0;

void vertex() {
	float x = TIME * 5.0 + randomness;
	VERTEX.x += malfunction * ((sin(x)/10.0) + (sin(2.77*x)/18.0));
}

void fragment() {
	ALBEDO = vec3(0.5, 0.5, 0.75);
	ROUGHNESS = 2.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
