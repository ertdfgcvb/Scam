/**
 * @title: RandomBoxes
 * @author: Andreas
 */

public class AnimStrobo extends Anim {
  void init() {
  }

  void render(PGraphics target, int eye, int time) {        
    
    float s = map(sin(time * 0.001), -1, 1, 0.999, 1.1);
    target.pushMatrix();
    //target.resetMatrix();
    target.translate(target.width/2, target.height/2);
    target.scale(s);
    target.image(target, -target.width/2, -target.height/2);
    target.popMatrix();

    
    target.fill(frameCount % 2 * 255);     
    //target.lights();
    target.translate(target.width/2, target.height/2);
    target.rotateX(time * 0.0011);
    target.rotateY(time * 0.0017);
    target.rotateZ(time * 0.0021);
    target.noStroke();
    float tx = map(sin(time * 0.005), -1, 1, target.height * 0.1, target.height * 0.4);
    target.translate(tx, 0, 0);    
    target.sphere(target.height * 0.2);   
    
    
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
