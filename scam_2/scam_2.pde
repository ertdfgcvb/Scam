/**
 * An example of a scene rendered with the separation for red/cyan glasses.
 *
 * Keyboard
 *   DOWN/UP : decrease/increase z (rendering only)
 *
 * Mouse
 *   CLICK   : toggle wireframe mode 
 */
 
PGraphics left, right;
PShader scamShader;
StereoCamera scam;

PVector pos, rot;
boolean wireframe = true;

boolean[] keys = new boolean[256]; // Key state.

void setup() {
  size(800, 600, P3D);  
  pixelDensity(displayDensity());  

  scam = new StereoCamera();  
  left = createGraphics(width, height, P3D);
  right = createGraphics(width, height, P3D);

  scamShader = loadShader("comp.glsl");
  scamShader.set("left", left);
  scamShader.set("right", right);  

  pos = new PVector(width/2, height/2, -500);
  rot = new PVector(0, 0, 0);
}

void draw() {
  
  // Position vector
  if (keys[UP]) {
    pos.z += 10;
    println("pos = " + pos);
  } else if (keys[DOWN]) {
    pos.z -= 10;
    println("pos = " + pos);
  }
  
  // Rotation vector (smoothed)
  rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1 ;
  rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;

  float l = 200;  // Size of the box.

  // Right eye
  right.beginDraw();
  scam.apply(right, StereoCamera.RIGHT);
  right.translate(pos.x, pos.y, pos.z);
  right.background(100);
  if (wireframe) {
    right.noFill();
  } else {
    right.fill(200);
  }
  right.stroke(0);
  right.rotateX(rot.x);
  right.rotateY(rot.y);
  right.rotateZ(rot.y);
  right.box(l * 3, l, l);
  right.box(l, l * 3, l);
  right.box(l, l, l * 3);
  right.endDraw();

  // Left eye
  left.beginDraw();
  scam.apply(left, StereoCamera.LEFT);
  left.translate(pos.x, pos.y, pos.z);
  left.background(100);
  if (wireframe) {
    left.noFill();
  } else {
    left.fill(200);
  }
  left.stroke(0);
  left.rotateX(rot.x);
  left.rotateY(rot.y);
  left.rotateZ(rot.y);    
  left.box(l * 3, l, l);
  left.box(l, l * 3, l);
  left.box(l, l, l * 3);
  left.endDraw();

  filter(scamShader);
}

void keyPressed() {
  if (keyCode < keys.length) keys[keyCode] = true;
}

void keyReleased() {
  if (keyCode < keys.length) keys[keyCode] = false;
}

void mousePressed() {
  wireframe = !wireframe;
}
