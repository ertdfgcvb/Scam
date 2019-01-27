/**
 * @title: AnimTibor2
 * @author: Tibor
 */

public class AnimTibor2 extends Anim {
  PVector pos, rot;
  boolean wireframe = true;
  boolean[] keys = new boolean[256]; // Key state.
  float increment = 0.02;

  void init() {  
    pos = new PVector();
    rot = new PVector();
  }
  void render(PGraphics t, int eye, int millis) { 

    //scam.FOV = mouseX / 100.0;
    //println(scam.FOV);




    if (eye == StereoCamera.LEFT||eye == StereoCamera.CENTER) {

      pos.x = t.width/2;
      pos.y = t.height/2;
      if (keys[UP]) {
        pos.z += 10;
        println("pos = " + pos);
      } else if (keys[DOWN]) {
        pos.z -= 10;
        println("pos = " + pos);
      }

      rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1;
      rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;
    }

    float l = t.height * 0.2;
    t.background(100);
    t.noStroke();
    t.fill(255);
    t.rect(-100, 0, width * 3, height * 3);

    t.translate(pos.x, pos.y, pos.z);
    t.stroke(0);
    //t.rotateX(rot.x);
    //t.rotateY(rot.y);
    //t.rotateZ(rot.y);    
    //t.box(l * 3, l, l);
    //t.box(l, l * 3, l);
    //t.box(l, l, l * 3);

    // noiseDetail(8, detail);

    float cols = 10;
    float rows = 5;

    float s = 20;
    float delta = s * 8;


    /*
    beginShape();
     t.vertex(-100, -100);
     vertex(100, -100);
     vertex(100, 100);
     vertex(-100, 100);
     endShape();*/

    for (float c = 0; c < cols; c++) {
      for (float r = 0; r < rows; r++) {
        //t.fill(200, 0, 255);
        noStroke();
        t.pushMatrix();

        t.translate(c * delta - (cols -1) * delta / 2.0, r * delta - (rows - 1) * delta / 2.0);

        t.noStroke();
        t.lights();

        float z = noise(frameCount / 10.0 + c / cols, r / rows);
        t.scale(3.5, 3.5, z * 22);
        t.sphere(s);
        t.popMatrix();
      }
    }

    t.endDraw();
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
