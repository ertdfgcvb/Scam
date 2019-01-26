PGraphics left, right;
PGraphics rt;  // render target
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
  rt = createGraphics(1920, 1080, P3D);
  left = createGraphics(rt.width, rt.height, P3D);
  right = createGraphics(rt.width, rt.height, P3D);

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

    rt.beginDraw();
    rt.filter(compose);
    rt.endDraw();
  } else {
    rt.beginDraw();
    rt.pushStyle();
    rt.push();
    scam.apply(rt, StereoCamera.CENTER);
    anim.render(rt, StereoCamera.CENTER, time);  
    rt.pop();
    rt.popStyle();
    rt.endDraw();
  }
  
  background(0);
  image(rt, 10, 10, rt.width * 0.5, rt.height * 0.5);
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
