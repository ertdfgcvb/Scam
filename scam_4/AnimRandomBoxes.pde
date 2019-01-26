/**
 * @title: RandomBoxes
 * @author: Andreas
 */

public class AnimRandomBoxes extends Anim {

  void init() {
  }

  void render(PGraphics target, int eye, int time) {    
    target.background(100);
    target.fill(255);
    target.stroke(0);
    target.translate(target.width/2, target.height/2);
    target.rotateX(time * 0.00041);
    target.rotateY(time * 0.00052);
    target.rotateZ(time * 0.00061);
    randomSeed(0);
    float w = target.width * 0.4;
    for (int i=0; i<1000; i++) {

      float x = random(-w, w);
      float y = random(-w, w);
      float z = random(-w, w);

      target.pushMatrix();
      target.translate(x, y, z);
      target.box(20);
      target.popMatrix();
    }
  }

  void mousePressed() {
  }

  void mouseReleased() {
  }

  void mouseMoved() {
  }

  void mouseDragged() {
  }

  void keyPressed() {
  }

  void keyReleased() {
  }
}
