 PImage[] monsters;
 
 void loadImages(){
  //load the images
    monsters = new PImage[5];
    for (int i = 0; i < monsters.length; i++) {
      monsters[i] = loadImage("monster" + i + ".png");
      monsters[i].resize(width/2, height/2);
    }
    
 }