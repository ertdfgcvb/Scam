/**
 * @title: Fresh
 * @author: Andreas
 */

public class AnimNoiseCube extends Anim {

  PVector pos, rot; 
  boolean[] keys = new boolean[256]; // Key state.


  void init() {

    pos = new PVector(0, 0, -500);
    rot = new PVector(0, 0, 0);
    noiseSeed(1);
  }

  void render(PGraphics target, int eye, int millis) {

    if (eye == StereoCamera.LEFT || eye == StereoCamera.CENTER) {
      if (keys[UP]) {
        pos.z += 10;
        println("pos = " + pos);
      } else if (keys[DOWN]) {
        pos.z -= 10;
        println("pos = " + pos);
      }


      rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1 ;
      rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;
    }


    int num = 18;                          
    float size = target.height / 16.0;     
    float space = map(sin(millis*0.0005), -1, 1, size, size * 3); 
    float off = (num-1) * space / 2;       

    float noiseScaler = map(cos(millis * 0.0003), -1, 1, 0.006, 0.2);

    PMatrix3D m = new PMatrix3D(); 
    m.translate(target.width/2 + pos.x, target.height/2 + pos.y, pos.z);
    m.rotateX(rot.x);
    m.rotateY(rot.y);
    m.rotateZ(rot.z);

    target.background(100);
    target.stroke(0);  
    // target.noStroke();
    target.pushMatrix();
    target.lights();    
    target.applyMatrix(m);

    for (int k=0; k<num; k++) {
      for (int j=0; j<num; j++) {
        for (int i=0; i<num; i++) {

          if (noise(i*noiseScaler, j*noiseScaler, k*noiseScaler) < 0.6) continue;

          if (i % 2 == 0) {
            target.fill(255, 120, 200);
          } else {
            target.fill(255, 230, 180);
          }

          target.pushMatrix();        
          target.translate(i * space - off, j * space - off, k * space - off);
          target.box(size, size, size);
          target.popMatrix();
        }
      }
    }
    target.popMatrix();
  }

  void keyPressed() {
    if (keyCode < keys.length) keys[keyCode] = true;
  }

  void keyReleased() {
    if (keyCode < keys.length) keys[keyCode] = false;
  }
}
