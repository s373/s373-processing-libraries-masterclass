///  graffimero, absolut lab, 2010, André Sier

import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

/// arraylist como colecção dinâmica de elementos
ArrayList parts;
PFont f;
float friccao = 0.961;

// video cam & flob 
Capture video;
Flob flob; 


void setup(){
    //bug 882 processing 1.0.1
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(800,600,OPENGL);
  f = createFont("sans-serif",12); 
  textFont(f,12);
  parts = new ArrayList(); //criar uma arraylist vazia
  Part novaPart = new Part(width/2,height/2);
  parts.add(novaPart); // adicionar um elemento

  //construct video & tracking
  video = new Capture(this, 128, 128, 30); // video 128x128px a 30fps
  flob = new Flob(video, width,height); 
  // config flob
  flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setTresh(10); 
  flob.setImage(0);
  flob.setBlur(5); 
  flob.setMirror(true,false);
  flob.setFade(25);
  flob.setMinNumPixels(50);


}

void draw(){

  if(video.available()) {
    video.read();  //ler img da camara
    flob.calc(flob.binarize(video)); //calcular blobs baseadas img cam
    
    for(int i=0; i< flob.getNumBlobs(); i++){ 
      ABlob ab = flob.getABlob(i); // para cada blob
      Part p = new Part(ab.cx, ab.cy); // criar part na pos da blob
      parts.add(p); // adionar a part a arraylist global
    }

  }

  //  background(127);
  tint(255,20);
  image(flob.getSrcImage(),0,0,width,height);


  noStroke();
  fill(255);
  text("partículas: "+parts.size()+"\nfriccao: "+friccao+" (f/F ajustar)\nfps: "+frameRate,
  5,height-45);

  if(mousePressed){
    Part p = new Part(mouseX,mouseY);
    parts.add(p);
  }

  for (int i=0; i<parts.size();i++){
    Part p = (Part) parts.get(i);
    if(!p.active)
      parts.remove(i);
    else
      p.render();
  }

}


void keyPressed(){
  if(key=='f')
    friccao-=0.01;
  if(key=='F')
    friccao+=0.01;

  if(key=='s')
    saveFrame("flob-arraylist-#####.jpg");

}





