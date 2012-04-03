import processing.opengl.*;
import s373.dna.*;


LineAgent la;

void setup(){
   size(500,500,OPENGL);
   la = new LineAgent(width/2, height/2);
   stroke(0,100);
}


void draw(){
  background(255);
  la.render();
}

void keyPressed(){
   if(key==' ')
    la = new LineAgent(width/2, height/2);
   if(key=='m')
    la.mutate(0.001);
}
