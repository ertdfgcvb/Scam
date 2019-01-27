/**
 * @title: La déconfiture
 * @author: Cassandre
 */

public class AnimText extends Anim {

  String[] phrase1 = { 
    "VOUS", "RAPPELEZ-VOUS", "VIEUX AMIS", "MES FRÈRES", "CES", "ANNÉES", "DE", "JOIE", "OÙ", "LA VIE", "N'ETAIT", "QU'UN TRIOMPHE", "ET", "QU'UN RIRE", "?"  
  }; 

  String[] phrase2 = { 
    "Tu te", "regardes", "dans le", "miroir", "et tu", "ne vois", "qu'un tas", "de chair.", "", "Tu espères toujours", "qu'il y existe", "un peu d'humanité."
  }; 

  String[] phrase3 = { 
    "À", "CROIRE", "QUE", "LES", "FOUDRES", "DES", "DIEUX", "SONT", "INÉVITABLES"
  }; 
  PFont font1, font2;

  int seed;
  

  void init() { 

    font1 = res.loadFont("Text/Alegreya-BoldItalic-48.vlw");  
    font2 = res.loadFont("Text/Executive-35Thin-48.vlw");  
    seed = millis();

  }

  void render(PGraphics target, int eye, int time) {
    target.background(#1B1086);

    target.textSize(40);

    target.textAlign(CENTER);
    randomSeed(seed);    
    for (int i=0; i<phrase1.length; i++) {
      target.pushMatrix();
      target.textFont(font2); 
      float x = random(-500, 500);
      float y = -i * mouseY+100 *4;
      float z = -i * mouseX+100 *4;
      target.translate(target.width/4 + x, target.height/2 + y, z);
      //target.rotateY(target.height +y);
      //target.text(phrase1[(i*mouseX)/width], 0, 0);
      target.fill(255);
      target.text(phrase1[i], 0, 0);
      target.fill(#1B1086);
      target.stroke(#C0E300);
      target.rect(-4000, 0, 10000, 10000);
      target.fill(255);
      target.popMatrix();
    }
    for (int i=0; i<phrase2.length; i++) {
      target.pushMatrix();
      target.textFont(font1); 
      float x = random(-50, 50);
      float y = i * 500 + sin(time * 0.0002) * 6000;
      float z = 100;
      target.translate(target.width/4 + x, target.height/2 + y, z);
      target.fill(255);
      target.text(phrase2[i], 0, 0);
      target.popMatrix();
    }
    for (int i=0; i<phrase3.length; i++) {
      target.pushMatrix();
      target.textFont(font1); 
      float x = -i * 500 + sin(time * 0.0003) * 4000;
      float y = -i * 500 + sin(time * 0.0003) * 4000;
      float z = -i * 500 + sin(time * 0.0003) * 4000;
      target.translate(target.width/4 + x, target.height/3 + y, z);
      target.line(x, y, x+width, y+width);
      target.text(phrase3[i], 0, 0);
      target.popMatrix();
    }
    target.ellipse(target.width-200, 100, width-mouseX, width-mouseX);
    //formule pour que plus la valeur de mouseX est grande, plus l'ellipse est petite

  }
}
