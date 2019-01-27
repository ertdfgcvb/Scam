/**
 * @title: AnimParallax
 * @author: Sonia Parani, Matthieu Minguet, Karian Før
 */

public class AnimParallax extends Anim {
  PShape i1;
  PShape i2;
  PShape i3;

  void init() {
    i1 = res.loadShape("Parallax/1.svg");
    i2 = res.loadShape("Parallax/2.svg");
    i3 = res.loadShape("Parallax/3.svg");
  }

  void render(PGraphics target, int eye, int millis) {
    target.background(0);
    target.shapeMode(CENTER);
    float x = 0;
    float y = 0;
    float z = 0;
    float speed = millis * map(mouseX, 0, width, 1, 3);
    float depth = map(mouseY, 0, height, 0, -500);

    i1.disableStyle();
    i2.disableStyle();
    i3.disableStyle();

    target.pushMatrix();
    target.translate(width/2, height/2, 0);
    x = (width*2) - (speed) % (i1.width*3);
    y = 100;
    z = depth + 0;
    target.translate(x, y, z);
    target.fill(color(255));
    target.strokeWeight(1);
    target.stroke(color(0));
    target.shape(i1, 0, 0);
    target.popMatrix();

    target.pushMatrix();
    target.translate(width/2, height/2, 0);
    x = (width*2) - (speed * 0.5) % (i2.width*3);
    y = -200;
    z = depth + -300;
    target.translate(x, y, z);
    target.fill(color(255));
    target.strokeWeight(1);
    target.stroke(color(0));
    target.shape(i2, 0, 0);
    target.popMatrix();

    target.pushMatrix();
    target.translate(width/2, height/2, 0);
    x = (width*2) - (speed * 0.3) % (i3.width*3);
    y = -600;
    z = depth + -600;
    target.translate(x, y, z);
    target.fill(color(255));
    target.strokeWeight(1);
    target.stroke(color(0));
    target.shape(i3, 0, 0);
    target.popMatrix();

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
