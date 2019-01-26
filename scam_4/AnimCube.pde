/**
 * @title: Cube
 * @author: Andreas
 */
public class AnimCube extends Anim {
  PVector pos, rot;
  boolean wireframe = true;
  boolean[] keys = new boolean[256]; // Key state.

  void init() {  
    pos = new PVector();
    rot = new PVector();
  }
  void render(PGraphics target, int eye, int millis) { 
    // Position vector
    if (eye == StereoCamera.LEFT||eye == StereoCamera.CENTER) {
      pos.x = target.width/2;
      pos.y = target.height/2;
      if (keys[UP]) {
        pos.z += 10;
        println("pos = " + pos);
      } else if (keys[DOWN]) {
        pos.z -= 10;
        println("pos = " + pos);
      }
      
      // Rotation vector (smoothed)
      rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1;
      rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;
    }

    float l = target.height * 0.2;
    target.background(100);
    target.translate(pos.x, pos.y, pos.z);
    target.stroke(0);
    target.rotateX(rot.x);
    target.rotateY(rot.y);
    target.rotateZ(rot.y);    
    target.box(l * 3, l, l);
    target.box(l, l * 3, l);
    target.box(l, l, l * 3);
  }  
  void keyPressed() {
    if (keyCode < keys.length) keys[keyCode] = true;
  }
  void keyReleased() {
    if (keyCode < keys.length) keys[keyCode] = false;
  }
  void mouseMoved() {
  }
  void mousePressed() {
  }
  void mouseReleased() {
  }
}
