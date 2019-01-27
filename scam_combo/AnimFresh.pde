/**
 * @title: Fresh
 * @author: Andreas
 */
 
public class AnimFresh extends Anim {

  void render(PGraphics target, int eye, int millis) {

    float cx = target.width/2 + cos(frameCount*0.042) * 60;
    float cy = target.height/2 + cos(frameCount*0.031) * 60;
    float cz = map(cos(frameCount*0.027), -1, 1, -300, 100);
    float inc = map(cos(frameCount*0.037), -1, 1, 5, 60);
    float r1 = map(cos(frameCount*0.037), -1, 1, 800, 2000);  
    float d = r1 * 0.325;
    int num = 7;
    target.background(0);
    target.stroke(0, 60);
    for (int i=num; i>=0; i--) {
      float r2 = r1 - d;
      float ang = cos(frameCount * 0.003 * (i + 1) );
      target.fill(map(i, num+1, 0, 0, 255));
      star(target, cx, cy, cz, ang, r1, r2, 30);
      r1 = r2 * 0.97;
      d *= 0.651;
      cz += inc;
    }

    target.fill(0);
    target.shapeMode(CENTER);
    target.pushMatrix();
    target.translate(cx, cy, cz);
    target.rotateZ(cos(-frameCount * 0.029));
    target.scale(map(cos(frameCount * 0.019), -1, 1, 0.15, 0.75));

    //float r = map(cos(frameCount * 0.19), -1, 1, 0, 255);
    //float g = map(cos(frameCount * 0.20), -1, 1, 0, 255);
    //float b = map(cos(frameCount * 0.21), -1, 1, 0, 255);      
    //s.disableStyle();
    //target.fill(r,g,b); 
    //target.shape(fresh, 0, 0, 300, 100);

    target.popMatrix();
  }

  void star(PGraphics target, float x, float y, float z, float ang, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    target.beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a + ang) * radius2;
      float sy = y + sin(a + ang) * radius2;
      target.vertex(sx, sy, z);
      sx = x + cos(a+halfAngle + ang) * radius1;
      sy = y + sin(a+halfAngle + ang) * radius1;
      target.vertex(sx, sy, z);
    }
    target.endShape(CLOSE);
  }
}
