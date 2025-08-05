//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float frame;

void main() {
  vec4 pixel_color = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

  vec3 color_flash = pixel_color.rgb * vec3(0.0, 1.5, 2.0);
  vec3 white = vec3(1.0, 1.0, 1.0);

  vec3 final_color = clamp(frame, 6.0, 12.0) == frame ? white : color_flash;
  
  gl_FragColor = vec4(final_color, pixel_color.a);

}
