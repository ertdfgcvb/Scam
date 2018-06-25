/**
 * An example of a scene rendered with the separation for red/cyan glasses.
 * The main scene is rendered twice trough the "render()" function
 * and then composed by a simple shader.  
 *
 * Keyboard:
 *     DOWN/UP    decrease/increase z (rendering only)
 *     LEFT/RIGHT decrease/increase scam.eyeSeparation
 *     C/V        decrease/increase scam.convergence
 *     G/H        decrease/increase gamma (uniform)
 *
 * Mouse:
 *     CLICK      toggle anaglyph mode
 *
 * @author Andreas Gysin
 */

PGraphics left, right;             // Textures for separate left / right rendering.  
PShader shader;                    // Shader used to merge the two textures.
StereoCamera scam;                

PVector pos, rot;                  // position and rotation of the scene.
float gamma = 1.4;                 // Gamma (uniform).
boolean anaglyph = true;           // anaglyph mode.

boolean[] keys = new boolean[256]; // Key state.

void setup() {
  size(800, 600, P3D);
  pixelDensity(displayDensity());  

  scam = new StereoCamera();  
  left = createGraphics(width, height, P3D);
  right = createGraphics(width, height, P3D);
  shader = loadShader("scam.glsl");
  shader.set("left", left);
  shader.set("right", right); 

  pos = new PVector(width/2, height/2, -500);
  rot = new PVector(0, 0, 0);

  noiseSeed(1);
}

void draw() {

  int t = millis(); // Store time.
  //rot.x = sin(t * 0.000013) * TWO_PI * 3;
  //rot.y = sin(t * 0.000014) * TWO_PI * 3;
  //rot.z = sin(t * 0.000016) * TWO_PI * 3;
  rot.x += ((height/2 - mouseY) * 0.01 - rot.x) * 0.1 ;
  rot.y += ((width/2 - mouseX) * 0.01 - rot.y) * 0.1;

  // Key handler:
  if (keys[UP]) {
    pos.z += 10;
    println("pos = " + pos);
  } else if (keys[DOWN]) {
    pos.z -= 10;
    println("pos = " + pos);
  }
  
  if (keys[RIGHT]) {
    scam.eyeSeparation += 0.5;
    println("scam.eyeSeparation = " + scam.eyeSeparation);
  } else if (keys[LEFT]) {
    scam.eyeSeparation -= 0.5;
    println("scam.eyeSeparation = " + scam.eyeSeparation);
  }
  
  if (keys['V']) {
    scam.convergence += 10;
    println("scam.convergence = " + scam.convergence);
  } else if (keys['C']) {
    scam.convergence = max(scam.convergence - 10, 0);
    println("scam.convergence = " + scam.convergence);
  }

  if (keys['H']) {
    gamma += 0.02;
    shader.set("gamma", gamma);
    println("gamma: " + gamma);
  } else if (keys['G']) {
    gamma = max(gamma - 0.02, 0);
    shader.set("gamma", gamma);
    println("gamma: " + gamma);
  }

  if (anaglyph) {
    right.beginDraw();
    scam.apply(right, StereoCamera.RIGHT);
    render(right, t, pos, rot);
    right.endDraw();

    left.beginDraw();
    scam.apply(left, StereoCamera.LEFT);
    render(left, t, pos, rot);
    left.endDraw();

    filter(shader);
  } else {
    scam.apply(g, StereoCamera.CENTER);
    render(g, t, pos, rot);
  }
}

void render(PGraphics g, int t, PVector pos, PVector rot) {
  int num = 24;                    // number of boxes per side
  float space = 34;                // box spacing
  float size = 34;                 // box size
  float off = (num-1) * space / 2; // center 
  
  float noiseScaler = map(cos(t * 0.0003), -1, 1, 0.006, 0.2);

  PMatrix3D m = new PMatrix3D(); 
  m.translate(pos.x, pos.y, pos.z);
  m.rotateX(rot.x);
  m.rotateY(rot.y);
  m.rotateZ(rot.z);

  g.background(100);
  g.stroke(0);  
  // g.noStroke();
  g.pushMatrix();
  g.lights();    
  g.applyMatrix(m);

  for (int k=0; k<num; k++) {
    for (int j=0; j<num; j++) {
      for (int i=0; i<num; i++) {

        if (noise(i*noiseScaler, j*noiseScaler, k*noiseScaler) < 0.6) continue;

        if (i % 2 == 0) {
          g.fill(255, 120, 200);
        } else {
          g.fill(255, 230, 180);
        }

        g.pushMatrix();        
        g.translate(i * space - off, j * space - off, k * space - off);
        g.box(size, size, size);
        g.popMatrix();
      }
    }
  }
  g.popMatrix();
}

void keyPressed() {
  if (keyCode < keys.length) keys[keyCode] = true;
}

void keyReleased() {
  if (keyCode < keys.length) keys[keyCode] = false;
}

void mousePressed() {
  anaglyph = !anaglyph;
}
