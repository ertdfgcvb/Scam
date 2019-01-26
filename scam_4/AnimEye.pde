/**
 * @title: Eye
 * @author: Andreas
 */
public class AnimEye extends Anim {
  PImage e;

  void init() {  
    e = res.loadImage("Eye/e.png");
  }
  void render(PGraphics target, int eye, int time) {
    float offs = sin(time * 0.001) * 20;
    float s = 0;

    if (eye == StereoCamera.LEFT) {
      s = -offs;
    } else if (eye == StereoCamera.RIGHT) {
      s = offs;
    } 
    target.background(100);    
    target.translate(right.width/2 + s, right.height/2);
    target.image(e, -e.width/2, -e.width/2);
  }  
  void keyPressed() {
  }
  void keyReleased() {
  }
  void mouseMoved() {
  }
  void mousePressed() {
  }
  void mouseReleased() {
  }
}
