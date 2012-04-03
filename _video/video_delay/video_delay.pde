// video delay, andré sier, 2008
// mouseX controls the delay amount

import processing.video.*;
PImage frames[];
Capture cam;
int time = 5*30;//60*30;//1min@30pfs frames
int timehead, timeoffset, timeread;

void setup(){
  size(640,240);
  frameRate(30);
  frames = new PImage[time];
  for(int i=0;i<frames.length;i++){
    frames[i] = new PImage(width/2,height); 
  }
  cam = new Capture(this,width/2,height,30);
}

void draw(){

  if(cam.available()){
    cam.read(); 
    timehead = (timehead + 1) % frames.length;
    frames[timehead].copy(cam,0,0,320,240,0,0,320,240);
    timeoffset = (int)map(mouseX,0,width,time,0);
    timeread = (timehead + timeoffset) % frames.length;

    image(frames[timehead],0,0,320,240);
    image(frames[timeread],320,0,320,240);
  }

}

