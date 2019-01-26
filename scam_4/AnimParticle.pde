public class AnimParticle extends Anim {
  PVector pos, rot;
  boolean wireframe = true;
  boolean[] keys = new boolean[256]; // Key state.
  ParticleSystem ps = new ParticleSystem();
  Timer timer = new Timer();

  void init() {  
    pos = new PVector();
    rot = new PVector();

    timer.start();

    ps.addParticles(200);
  }

  void render(PGraphics target, int eye, int millis) { 
    // Position vector
    if (eye == StereoCamera.LEFT||eye == StereoCamera.CENTER) {
      pos.x = target.width/2;
      pos.y = target.height/2;
      if (keys[UP]) {
        pos.z += 10;
        println("pos = " + pos);
      } else if (keys[DOWN]) {
        pos.z -= 10;
        println("pos = " + pos);
      }

      // Rotation vector (smoothed)
      rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1;
      rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;
    }

    float l = target.height * 0.2;
    target.background(100);
    target.translate(pos.x, pos.y, pos.z);
    target.rotateX(rot.x);
    target.rotateY(rot.y);
    target.rotateZ(rot.y); 

    ps.draw(target, eye, timer.getElapsedTime());
    
    if (eye == StereoCamera.CENTER || eye == StereoCamera.LEFT)
    {
      ps.animate(timer.getElapsedTime());
      ps.addParticles(7);
    }

    target.endDraw();
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
    ps = new ParticleSystem();
    ps.addParticles(100);
  }
  void mouseReleased() {
  }
}

class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();

  void addParticles(int n)
  {
    for (int i = 0; i < n; ++i)
      particles.add(new Particle());
  }

  void draw(PGraphics target, int eye, int millis)
  {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.draw(target, eye, millis);
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void animate(int millis)
  {
    for (Particle p : particles)
    {
      p.animate(millis);
    }
  }
}

float easeInOutQuint(float t, float b, float c, float d)
{
  if ( (t /= d / 2) < 1)
    return c / 2 * t * t * t * t * t + b;
  else
    return c / 2 * ((t -= 2)* t * t * t * t + 2) + b;
}

//Example of rotating PVector about a directional PVector
PVector rotate(PVector v, PVector r, float a) {
  Quaternion Q1 = new Quaternion(0, v.x, v.y, v.z);
  Quaternion Q2 = new Quaternion(cos(a / 2), r.x * sin(a / 2), r.y * sin(a / 2), r.z * sin(a / 2));
  Quaternion Q3 = Q2.mult(Q1).mult(Q2.conjugate());
  return new PVector(Q3.X, Q3.Y, Q3.Z);
}

class Particle
{
  PVector orgPos;
  PVector curPos;
  PVector velocity;
  PVector acceleration;
  int size;
  float lifeSpan;
  float curLife;
  int lastTime;
  boolean easingIn = true;
  Timer timer = new Timer();

  Particle()
  {
    orgPos = new PVector(0, 0, 0);
    size = (int)random(20, 100);
    curPos = orgPos.copy();
    acceleration = new PVector(0.09, 0.09, -0.09);
    velocity = new PVector(0.5 * random(-1, 1) - 0.4, 1 - 1 * random(-2, 1), 4 * random(-2, 1) - 0.4);
    
    timer = new Timer();
    timer.start();

    lifeSpan = random(10000, 12000);
    curLife  = lifeSpan;
  }

  void draw(PGraphics target, int eye, int millis)
  {
    target.pushMatrix();
    target.pushStyle();
    target.translate(orgPos.x, orgPos.y, orgPos.z);
    
    // fill in color
    target.fill(easeInOutQuint(timer.getElapsedTime(), 239, 255, lifeSpan),
                easeInOutQuint(timer.getElapsedTime(), 215, 255, lifeSpan),
                easeInOutQuint(timer.getElapsedTime(), 28, 255, lifeSpan), 
                255 * timer.getElapsedTime() / lifeSpan);
                
    target.box(size, size, size); 
    target.popMatrix();
    target.popStyle();
  }

  void animate(int millis)
  {
    velocity.add(acceleration);
    orgPos.add(velocity);

    //orgPos.
  }

  boolean isDead() {
    if (timer.getElapsedTime() >= lifeSpan) {
      return true;
    } else {
      return false;
    }
  }
}
