/**
 * @title: AnimParticle
 * @author: Louka
 */

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
  /***************************************************************************
   * Quaternion class written by BlackAxe / Kolor aka Laurent Schmalen in 1997
   * Translated to Java(with Processing) by RangerMauve in 2012
   * this class is freeware. you are fully allowed to use this class in non-
   * commercial products. Use in commercial environment is strictly prohibited
   */

  public class Quaternion {
    public  float W, X, Y, Z;      // components of a quaternion

    // default constructor
    public Quaternion() {
      W = 1.0;
      X = 0.0;
      Y = 0.0;
      Z = 0.0;
    }

    // initialized constructor

    public Quaternion(float w, float x, float y, float z) {
      W = w;
      X = x;
      Y = y;
      Z = z;
    }

    // quaternion multiplication
    public Quaternion mult (Quaternion q) {
      float w = W*q.W - (X*q.X + Y*q.Y + Z*q.Z);

      float x = W*q.X + q.W*X + Y*q.Z - Z*q.Y;
      float y = W*q.Y + q.W*Y + Z*q.X - X*q.Z;
      float z = W*q.Z + q.W*Z + X*q.Y - Y*q.X;

      W = w;
      X = x;
      Y = y;
      Z = z;
      return this;
    }

    // conjugates the quaternion
    public Quaternion conjugate () {
      X = -X;
      Y = -Y;
      Z = -Z;
      return this;
    }

    // inverts the quaternion
    public Quaternion reciprical () {
      float norme = sqrt(W*W + X*X + Y*Y + Z*Z);
      if (norme == 0.0)
        norme = 1.0;

      float recip = 1.0 / norme;

      W =  W * recip;
      X = -X * recip;
      Y = -Y * recip;
      Z = -Z * recip;

      return this;
    }

    // sets to unit quaternion
    public Quaternion normalize() {
      float norme = sqrt(W*W + X*X + Y*Y + Z*Z);
      if (norme == 0.0)
      {
        W = 1.0; 
        X = Y = Z = 0.0;
      } else
      {
        float recip = 1.0/norme;

        W *= recip;
        X *= recip;
        Y *= recip;
        Z *= recip;
      }
      return this;
    }

    // Makes quaternion from axis
    public Quaternion fromAxis(float Angle, float x, float y, float z) { 
      float omega, s, c;
      int i;

      s = sqrt(x*x + y*y + z*z);

      if (abs(s) > Float.MIN_VALUE)
      {
        c = 1.0/s;

        x *= c;
        y *= c;
        z *= c;

        omega = -0.5f * Angle;
        s = (float)sin(omega);

        X = s*x;
        Y = s*y;
        Z = s*z;
        W = (float)cos(omega);
      } else
      {
        X = Y = 0.0f;
        Z = 0.0f;
        W = 1.0f;
      }
      normalize();
      return this;
    }

    public Quaternion fromAxis(float Angle, PVector axis) {
      return this.fromAxis(Angle, axis.x, axis.y, axis.z);
    }

    // Rotates towards other quaternion
    public void slerp(Quaternion a, Quaternion b, float t)
    {
      float omega, cosom, sinom, sclp, sclq;
      int i;


      cosom = a.X*b.X + a.Y*b.Y + a.Z*b.Z + a.W*b.W;


      if ((1.0f+cosom) > Float.MIN_VALUE)
      {
        if ((1.0f-cosom) > Float.MIN_VALUE)
        {
          omega = acos(cosom);
          sinom = sin(omega);
          sclp = sin((1.0f-t)*omega) / sinom;
          sclq = sin(t*omega) / sinom;
        } else
        {
          sclp = 1.0f - t;
          sclq = t;
        }

        X = sclp*a.X + sclq*b.X;
        Y = sclp*a.Y + sclq*b.Y;
        Z = sclp*a.Z + sclq*b.Z;
        W = sclp*a.W + sclq*b.W;
      } else
      {
        X =-a.Y;
        Y = a.X;
        Z =-a.W;
        W = a.Z;

        sclp = sin((1.0f-t) * PI * 0.5);
        sclq = sin(t * PI * 0.5);

        X = sclp*a.X + sclq*b.X;
        Y = sclp*a.Y + sclq*b.Y;
        Z = sclp*a.Z + sclq*b.Z;
      }
    }

    public Quaternion exp()
    {                               
      float Mul;
      float Length = sqrt(X*X + Y*Y + Z*Z);

      if (Length > 1.0e-4)
        Mul = sin(Length)/Length;
      else
        Mul = 1.0;

      W = cos(Length);

      X *= Mul;
      Y *= Mul;
      Z *= Mul; 

      return this;
    }

    public Quaternion log()
    {
      float Length;

      Length = sqrt(X*X + Y*Y + Z*Z);
      Length = atan(Length/W);

      W = 0.0;

      X *= Length;
      Y *= Length;
      Z *= Length;

      return this;
    }
  };

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
}
