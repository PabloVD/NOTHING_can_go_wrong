shader_type canvas_item;
 
uniform sampler2D gradient:hint_normal;
uniform float inverted : hint_range(0.0, 1.0, 1.0) = 0.0;
uniform float opacity : hint_range(0.0, 1.0) = 1.0;
 
void fragment() {
    vec4 input_color = texture(TEXTURE, UV);
    float ycoord = mix(UV.y, 1.0 - UV.y, inverted);
    vec3 output_color = texture(gradient, vec2(ycoord, 0.0)).rgb;
    COLOR.rgb = output_color;
    COLOR.a = input_color.a * opacity;
}