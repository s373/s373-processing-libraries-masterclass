

AudioPlayer shoot;
AudioPlayer blast;
AudioPlayer gameOverSnd;

Minim minim;

void init_audio(){
  minim = new Minim(this);
  shoot = minim.loadFile("shot.aiff");
  blast = minim.loadFile("blast.aiff");  
  gameOverSnd = minim.loadFile("gameover.aiff");    
}

void playShoot(){
  shoot.rewind();
  shoot.play();
}

void playBlast(){
  blast.rewind();
  blast.play();
}

void playGameOver(){
  gameOverSnd.rewind();
  gameOverSnd.play();
}


void stop(){
 
   shoot.close();
   blast.close(); 
   gameOverSnd.close();
   
   super.stop();
  
}
