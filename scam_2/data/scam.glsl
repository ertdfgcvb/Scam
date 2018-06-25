/**
Also check:
http://www.3dtv.at/knowhow/anaglyphcomparison_en.aspx
*/

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D left, right;
uniform float gamma = 1.4;

vec3 applyGamma(vec3 color, float gamma) {
    return pow(color, vec3(1.0 / gamma));
}

void main() {
  vec3 l = vec4(texture2D(left, vertTexCoord.st)).rgb;
  vec3 r = vec4(texture2D(right, vertTexCoord.st)).rgb;

  vec3 rgb = vec3(0.7 * l.g + 0.3 * l.b, r.g, r.b);

  gl_FragColor = vec4(applyGamma(rgb, gamma), 1.0);
}