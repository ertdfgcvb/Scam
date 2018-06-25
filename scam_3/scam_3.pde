/**
 * An example use of the shader to compose an existing stereoscopic image.
 * Image source: 
 * https://en.wikipedia.org/wiki/File:Ferris_Wheel_from_balcony_of_Illinois_Building._Louisiana_Purchase_Exposition,_St._Louis,_by_Keystone_View_Company.jpg
 *
 * Keyboard:
 *     G/H        decrease/increase gamma
 * 
 * @author Andreas Gysin
 */

PShader shader;                    // Shader used to merge the two textures.
float gamma = 1.4;                 // Gamma (uniform).
boolean[] keys = new boolean[256]; // Key state.

void setup() {
  size(800, 600, P3D);
  pixelDensity(displayDensity());  

  PGraphics left = createGraphics(width, height, P3D);
  PGraphics right = createGraphics(width, height, P3D);
  shader = loadShader("scam.glsl");
  shader.set("left", left);
  shader.set("right", right);  
  
  PImage img = loadImage("Ferris_Wheel_from_balcony_of_Illinois_Building._Louisiana_Purchase_Exposition,_St._Louis,_by_Keystone_View_Company.jpg");
 
  // Copy the left and right portions of the image:
  PImage left_portion = img.get(258, 79, 1100, 1150);  
  PImage right_portion = img.get(1368, 79, 1100, 1150); 
 
  // Calculate the aspect ratio to fit the image into the sketch window:
  float a = (float) left_portion.width / left_portion.height;
  float b = (float) width / height;
  float w, h;
  if (a > b) {
    w = width;
    h = a * width;
  } else {
    w = a * height;
    h = height;
  } 
  
  right.beginDraw();
  right.background(0);
  right.imageMode(CENTER);
  right.image(right_portion, right.width/2, right.height/2, w, h);
  right.endDraw();

  left.beginDraw();
  left.background(0);
  left.imageMode(CENTER);
  left.image(left_portion, left.width/2, left.height/2, w, h);
  left.endDraw();
}

void draw() {
  if (keys['H']) {
    gamma += 0.02;
    shader.set("gamma", gamma);
    println("gamma: " + gamma);
  } else if (keys['G']) {
    gamma = max(gamma - 0.02, 0);
    shader.set("gamma", gamma);
    println("gamma: " + gamma);
  }

  filter(shader);
}

void keyPressed() {
  if (keyCode < keys.length) keys[keyCode] = true;
}

void keyReleased() {
  if (keyCode < keys.length) keys[keyCode] = false;
}
