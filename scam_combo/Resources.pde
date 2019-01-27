/**
 * Class to store already loaded resources in a map.
 */
 
class Resources {
  private HashMap <String, PImage> images; 
  private HashMap <String, PFont> fonts; 
  private HashMap <String, PShape> shapes; 
  PApplet parent;

  Resources(PApplet parent) {
    images = new HashMap();
    fonts = new HashMap();
    shapes = new HashMap();
    this.parent = parent;
  }
  
  int cacheSize(){
    
    return images.size() + fonts.size() + shapes.size();
  }

  public PImage loadImage(String str) {
    if (!images.containsKey(str)) {
      PImage img = parent.loadImage(str);
      if (img != null) images.put(str, img);
    }
    return images.get(str);
  }

  public PFont loadFont(String str) {
    if (!fonts.containsKey(str)) {
      PFont fnt = parent.loadFont(str);
      if (fnt != null) fonts.put(str, fnt);
    }
    return fonts.get(str);
  }

  public PShape loadShape(String str) {
    if (!shapes.containsKey(str)) {
      PShape img = parent.loadShape(str);
      if (img != null) shapes.put(str, img);
    }
    return shapes.get(str);
  }
}
