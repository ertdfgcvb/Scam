/**
 * Anaglyph stereo camera.
 * Allows to correctly calculate each eye’s view frustum to allow stereoscopic projection.
 *
 * Original code:
 * http://www.animesh.me/2011/05/rendering-3d-anaglyph-in-opengl.html
 *
 * @author Andreas Gysin (transcode)
 */

class StereoCamera {

  final static int CENTER = 3;
  final static int LEFT   = 37;
  final static int RIGHT  = 39;

  float convergence;           // Convergence distance (zero parallax)
  float eyeSeparation;         // Distance between the eyes
  float FOV;                   // Field of view 
  float nearClippingDistance;  // Clipping planes
  float farClippingDistance;

  StereoCamera() {
    convergence          = 2000.0;
    eyeSeparation        = 35.0;
    FOV                  = PI / 3.0;
    nearClippingDistance = 10.0f;
    farClippingDistance  = 20000.0;
  }

  void apply(PGraphics g, int eye) {
    float aspect = (float)g.width / g.height;
    float top    = nearClippingDistance * tan(FOV / 2);
    float bottom = -top;
    float sep = eyeSeparation / 2;  

    float a = aspect * tan(FOV / 2) * convergence;    
    float b = a - sep;
    float c = a + sep;
    float d = nearClippingDistance / convergence;

    float left, right;    
    if (eye == LEFT) {
      left = -b * d;
      right =  c * d;
    } else if (eye == RIGHT) { 
      left = -c * d;
      right =  b * d;
      sep = -sep;
    } else { // centered
      left = -a * d;
      right =  a * d;
      sep = 0;
    }
    g.frustum(left, right, bottom, top, nearClippingDistance, farClippingDistance);
    g.translate(sep, 0, 0);
  }
}
