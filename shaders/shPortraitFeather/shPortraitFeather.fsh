//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec2 v_vPosition;
varying vec4 v_vColour;

void main() {
    
    vec4 destination_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    float source_alpha = mix(1.0, 0.0, (v_vPosition.y - 239.0) / 20.0);
    destination_color.a = destination_color.a * source_alpha;
    gl_FragColor = destination_color;
}
