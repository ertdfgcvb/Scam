/**
 * @title: Growing
 * @author: Laura P
 */

public class AnimGrowing extends Anim {

  void render(PGraphics target, int eye, int time) {
    target.lights();
    target.background(100, 100, 100);
    target.fill(100, 100, 100);
    //target.noFill();
    target.stroke(1);
    //target.translate(400,300, 300);
    //target.translate(target.width/2, target.height/2);
    //target.translate(-target.width/2, -target.height/2, 0);
    //target.box(100,100,100);

    int sizeS = 30;
    float numX = (int)((target.width-100)/sizeS);
    float numY = (int)((target.height-100)/sizeS);

    for (int i = 0; i<numX; i++) {
      for (int j = 0; j<numY; j++) {
        target.pushMatrix();
        target.translate(50+(sizeS*i), 50+(sizeS*j), 0);
        float hei= map(sin((i*j)), -1, 1, 0, 500);
        float test = map(mouseX, 0, width, 0, hei);
        target.box(sizeS, sizeS, test );
        target.popMatrix();
      }
    }
  }
}
