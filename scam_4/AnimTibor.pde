public class AnimTibor extends Anim {
  PVector pos, rot;
  boolean wireframe = true;
  boolean[] keys = new boolean[256]; // Key state.
  float increment = 0.02;

  ArrayList<TParticle> particles;

  void init() {  
    pos = new PVector();
    rot = new PVector();
    particles = new ArrayList<TParticle>();
    for (int i = 0; i < 40; i++){
        particles.add(new TParticle());
    }
  }
  
  void render(PGraphics t, int eye, int millis) { 
   
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
    t.stroke(0);
    t.fill(255);
    
    t.stroke(0);

    float cols = 10;
    float rows = 10;
    
    float s = 7;
    float delta = s * 7;
    
    t.fill(255);
    
    t.translate(pos.x, pos.y, pos.z);
    t.lights();
    t.noStroke();
    for (int i = 0; i < particles.size(); i++){
      TParticle tp = particles.get(i);
      
      t.lights();
      tp.draw(t);

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
    for (int i = 0; i < particles.size(); i++){
       // particles.add(new TParticle());
      particles.get(i).oneAxis = !particles.get(i).oneAxis;
      particles.get(i).target = particles.get(i).pos;
    }
  }
  
  
  void mouseReleased() {
  }
}

public class TParticle {
  PVector pos;
  float size = 10;
  PVector target;
  float speed = 2;
  boolean oneAxis = true;
  
  TParticle() {
    target = new PVector();
    pos = new PVector();
  }
  
  void draw(PGraphics t) {
    if (target.dist(pos) > speed) {
      PVector dir = PVector.sub(target, pos);
      dir.normalize();
      pos = PVector.add(dir.mult(speed), pos);
    } else {
      pos = target;
      if (oneAxis) {
        float r = random(3);
        
        if (r < 1) {
          target = new PVector(random(-300, 300), pos.y, pos.z);

        } else if (r < 2) {
          target = new PVector(pos.x, random(-300, 300), pos.z);

        } else if (r < 3) {
          target = new PVector(pos.x, pos.y, random(-600, 300));

        } 
      
      } else {
        target = new PVector(random(-100, 100), random(-100, 100), random(-100, 100)).mult(3);

      }
    }
    
    t.pushMatrix();
    t.translate(pos.x, pos.y, pos.z);
    t.sphere(size);
    t.popMatrix();
  }
  
}