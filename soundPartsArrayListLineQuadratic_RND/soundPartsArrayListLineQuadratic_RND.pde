/*

sound particles 
André Sier, 2011

*/


import ddf.minim.*;
import ddf.minim.signals.*;
import processing.opengl.*;


Minim minim;
AudioOutput out;

ArrayList sndParts;


void setup(){
  size(400,700,OPENGL);
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
  println(out.bufferSize());
  
  sndParts = new ArrayList();

  fill(0,100);
  stroke(0,50);
}



void draw(){
  
  if(random(1000)<5){
     addPart(random(width), random(height)); 
  }
  
  
  
  background(255);
  
  // draw waveForm
  float ystride = (float) height / out.bufferSize();
  
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    line(width/2, i*ystride, width/2 + out.mix.get(i)*150, i*ystride);
  }

  
  // draw sndParts
  
  for(int i=0; i<sndParts.size(); i++) {
     
       SoundPart sp =  (SoundPart) sndParts.get(i);
       
       sp.update();
       
       sp.draw();
       
       if( sp.life >= 2) {
        
          sp.removeAudio();
         
          sndParts.remove(i); 
          i--;
         
       }
    
  }
  
  
  text("SoundParts: "+sndParts.size(), 5, height-15);
  
}



void addPart( float _x, float _y){
 
   SoundPart p = new SoundPart (_x, _y);
   
   sndParts.add(p); 
  
}


void mousePressed(){
  
   addPart(mouseX,mouseY);  
  
}


void mouseDragged(){

   if(frameCount % 5 != 0){
      return; 
   }
  
   addPart(mouseX,mouseY);  
  
}



