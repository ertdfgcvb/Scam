/**
 * @title: RandomBoxes
 * @author: Andreas
 * ...not really an anaglyph ;)
 */

public class AnimStrobo extends Anim {
  void init() {
  }

  void render(PGraphics target, int eye, int time) {        
    
    float s = map(sin(time * 0.001), -1, 1, 1.01, 1.1);
    target.pushMatrix();
    //target.resetMatrix();
    target.translate(target.width/2, target.height/2);
    target.scale(s);
    target.image(target, -target.width/2, -target.height/2);
    target.popMatrix();

    
    target.fill(frameCount % 2 * 255);     
    target.noStroke();
    float x = cos(time * 0.00027) * target.width * 0.3 + target.width / 2;
    float y = cos(time * 0.00031) * target.height * 0.3 + target.height / 2;
    float z = map(cos(time * 0.0010), -1, 1, 0, 300);
    float d = map(cos(time * 0.0021), -1, 1, target.height * 0.1, target.height * 0.4);
    float r = cos(time * 0.0003) * 10;
    target.noStroke();
    target.translate(x, y, z);
    target.rotate(r);
    target.rect(-d/10, -d/2, d/5, d);   
    target.rect(-d/2, -d/10, d, d/5);
    
    
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
