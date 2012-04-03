// simulações interactivas 2010
// jogo desenvolvido para projecto lineinvaders.tv


import ddf.minim.*;


InvadersGenerator invadersgenerator;
Hero hero;
boolean gameOver = true;
float gameOverSize = 0.0f;
float gameOverDir = 10.0f;

PFont guiFont;// = createFont("Monospace",12);
PFont overFont;// = createFont("Monospace",32);


void setup() {
  size(500,500,P2D);
  init_audio();
  guiFont = loadFont("Beatbox-14.vlw");
  overFont = loadFont("Beatbox-40.vlw");
  rectMode(CENTER);
  noStroke();

  frameRate(45);

  
  invadersgenerator = new InvadersGenerator();
  hero = new Hero();

  playGameOver();
}





void draw(){
  background(255);
  noStroke();
    
   if(!gameOver) {
     
     textFont(guiFont);
        if(hero.mode>0)  
          invadersgenerator.update();
        invadersgenerator.draw();
        hero.update();
        hero.draw();

   } else {
        
       textFont(guiFont);
     
        invadersgenerator.draw();
        hero.draw();
        textFont(overFont);
        fill(0);
        text("GAME OVER", 130, 250);

        gameOverSize += gameOverDir;
        if(gameOverSize < 0 || gameOverSize > 750)
          gameOverDir = -gameOverDir;
        ellipse(width/2, height/2, gameOverSize, gameOverSize);     

        fill(255);
        text("press any key", 80, 350);


   }

}




void keyPressed() {
  if(keyCode==LEFT || key == 'o' || key == 'a')
    hero.left = true;
  if(keyCode==RIGHT  || key == 'p' || key == 'd')
    hero.right = true;
  if(key==' '){
    hero.fire = true;
    hero.doFire = true;
  }
  
  
  
}

void keyReleased() {
  if(keyCode==LEFT|| key == 'o' || key == 'a')
    hero.left = false;
  if(keyCode==RIGHT || key == 'p' || key == 'd')
    hero.right = false;
  if(key==' ') {
    hero.fire = false;
  }
  
  if(gameOver){
   
     restart(); 
    
  }
  
}


void restart(){
 
   gameOver = false;
   invadersgenerator = new InvadersGenerator();
   hero = new Hero();
  
}


void mouseDragged() {
    hero.fire = true;
    hero.doFire = true;
}

void mousePressed() {
    hero.fire = true;
    hero.doFire = true;
}

void mouseReleased(){
    hero.fire = false;
}
