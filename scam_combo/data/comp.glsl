/**
 * Compose left and right color anaglyph images:
 * - partial color reproduction (not of red shades)
 * - almost no retinal rivalry
 * - gamma
 * source:
 * http://www.3dtv.at/knowhow/anaglyphcomparison_en.aspx
 */

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D left, right;
uniform float gamma = 1.5;


// gamma correction:
// https://www.siggraph.org/education/materials/HyperGraph/color/gamma_correction/gamma_intro.html
vec3 gammaF(vec3 color, float v) {
    return pow(color, vec3(1.0 / v));
}

void main() {
  vec3 l = gammaF(vec4(texture2D(left, vertTexCoord.st)).rgb, gamma);
  vec3 r = gammaF(vec4(texture2D(right, vertTexCoord.st)).rgb, gamma);
  vec3 col = vec3(0.7 * l.g + 0.3 * l.b, r.g, r.b);
  gl_FragColor = vec4(col, 1.0);
}
