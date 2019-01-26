PGraphics left, right;
PGraphics rt1;  // render target
PShader compose;
StereoCamera scam;
Resources res;
boolean stereo = true;
int currentAnim;
ArrayList<Class> classes;
Anim anim;

void setup() {  
  //fullScreen(P3D);
  size(1000, 700, P3D);
  //pixelDensity(displayDensity());  

  res = new Resources(this);
  scam = new StereoCamera(); 
  rt1 = createGraphics(800, 600, P3D);
  left = createGraphics(rt1.width, rt1.height, P3D);
  right = createGraphics(rt1.width, rt1.height, P3D);

  compose = loadShader("comp.glsl");  

  classes = getClasses(this, "Anim");
  println("............");
  for (Class c : classes) println("Anim class: " + c.getSimpleName());

  currentAnim = 0; // animation index
  anim = (Anim) createInstance(this, classes.get(currentAnim));
  anim.init();
  //compose.set("gamma", 1.0);
}

void draw() {


  int time = millis();

  if (stereo) {

    left.beginDraw();
    left.pushStyle();
    left.push();
    scam.apply(left, StereoCamera.LEFT);
    anim.render(left, StereoCamera.LEFT, time);  
    left.pop();
    left.popStyle();
    left.endDraw();

    right.beginDraw();
    right.pushStyle();
    right.push();
    scam.apply(right, StereoCamera.RIGHT);
    anim.render(right, StereoCamera.RIGHT, time);  
    right.pop();
    right.popStyle();
    right.endDraw();

    compose.set("left", left);
    compose.set("right", right);

    rt1.beginDraw();
    rt1.filter(compose);
    rt1.endDraw();
  } else {
    left.beginDraw();
    left.pushStyle();
    left.push();
    scam.apply(left, StereoCamera.CENTER);
    anim.render(left, StereoCamera.CENTER, time);  
    left.pop();
    left.popStyle();
    left.endDraw();
    rt1.beginDraw();
    rt1.image(left, 0, 0);
    rt1.endDraw();
  }
  background(0);
  image(rt1, 10, 10);
}

void keyPressed() {
  anim.keyPressed();
}

void keyReleased() {
  if (keyCode == RIGHT) {
    currentAnim = (currentAnim + 1) % classes.size();
    anim = (Anim) createInstance(this, classes.get(currentAnim));
    anim.init();
  } else if (keyCode == LEFT) {
    currentAnim = (currentAnim - 1 + classes.size()) % classes.size();
    anim = (Anim) createInstance(this, classes.get(currentAnim));
    anim.init();
  } else if (key == 's') {
    stereo = !stereo;
  }
  anim.keyReleased();
}

void mouseMoved() {
  anim.mouseMoved();
}

void mousePressed() {
  anim.mousePressed();
}

void mouseReleased() {
  anim.mouseReleased();
}  
