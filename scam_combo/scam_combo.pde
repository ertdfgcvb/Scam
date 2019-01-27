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
  size(1000, 720, P3D);  
  pixelDensity(displayDensity());  

  res = new Resources(this);
  scam = new StereoCamera(); 
  rt = createGraphics(1920, 1080, P3D);
  left = createGraphics(rt.width, rt.height, P3D);
  right = createGraphics(rt.width, rt.height, P3D);

  compose = loadShader("comp.glsl");  

  classes = getClasses(this, "Anim");
  for (Class c : classes) println("Anim class: " + c.getSimpleName());

  currentAnim = 0; // animation index
  anim = (Anim) createInstance(this, classes.get(currentAnim));
  anim.init();
  
  compose.set("gamma", 1.4); 
  textFont(loadFont("font.vlw"));
}

void draw() {

  int time = millis();

  if (stereo) {
    
    left.beginDraw();
    left.pushStyle();
    left.pushMatrix();
    scam.apply(left, StereoCamera.LEFT);
    anim.render(left, StereoCamera.LEFT, time);  
    left.popMatrix();
    left.popStyle();
    left.endDraw();

    right.beginDraw();
    right.pushStyle();
    right.pushMatrix();
    scam.apply(right, StereoCamera.RIGHT);
    anim.render(right, StereoCamera.RIGHT, time);  
    right.popMatrix();
    right.popStyle();
    right.endDraw();

    compose.set("left", left);
    compose.set("right", right);

    rt.beginDraw();
    rt.background(0);
    rt.filter(compose);
    rt.endDraw();    
  } else {
    rt.beginDraw();
    rt.pushStyle();
    rt.pushMatrix();
    scam.apply(rt, StereoCamera.CENTER);
    anim.render(rt, StereoCamera.CENTER, time);  
    rt.popMatrix();
    rt.popStyle();
    rt.endDraw();
  }
  
  // local preview:
  background(80);
  float m = 20; // margin;
  float w = width - m*2;
  float h = w / rt.width * rt.height;
  image(rt, m, m, w, h);
  
  // info
  String out = "";
  out += "FPS                : " + round(frameRate) + "\n";
  out += "Render target size : " + rt.width + "x" + rt.height + "\n";
  out += "Current instance   : " + classes.get(currentAnim).getSimpleName() + " [" + currentAnim + "/" + classes.size() + "]\n";
  out += "Cached resources   : " + res.cacheSize() + "\n";
  out += "LEFT/RIGHT         : change instance\n";
  out += ".                  : toggle stereoscopic view\n";
  text(out, m, h + m * 3);
  
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
  } else if (key == '.') {
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
