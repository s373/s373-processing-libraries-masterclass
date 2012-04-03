
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

int NUM_PARTICLES = 1000;
ParticleSystem p;

Capture video;
Flob flob; 
int videores = 128;
PFont font = createFont("Zapfino",50);

float tmouseX,tmouseY, cmouseX, cmouseY;

void setup()
{
  try { 
    quicktime.QTSession.open(); 
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace(); 
  }

  smooth();
//  size(1200,720,OPENGL);
  size(1024,768,OPENGL);
  background(0);
  p = new ParticleSystem();
  String[] devices = Capture.list();
  println(devices);

  video = new Capture(this, videores, videores,  devices[6], 30);  
  flob = new Flob(video, width, height);
  flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setMirror(true,false);
  flob.setThresh(12);//25);//16);
  flob.setFade(25);//2);//10);
  flob.setMinNumPixels(10);
  flob.setImage( 0 );
  flob.setBlur(0);

  textFont(font);
  strokeWeight(3);
   tmouseX = random(width); 
   tmouseY = random(height);     

}

void draw()
{

  if(frameCount%1250==0){
   tmouseX = random(width); 
   tmouseY = random(height);     
  }
  float lp = 0.25;  
  cmouseX += (tmouseX-cmouseX)*lp;
  cmouseY += (tmouseY-cmouseY)*lp;
 // println("target "+tmouseX+" "+cmouseX);
//  mouseX = (int)cmouseX;
//  mouseY = (int)cmouseY;
  
  if(video.available()) {   

    video.read();
    flob.calcsimple(  flob.binarize(video) ); 

    for(int i = 0; i < flob.getNumTrackedBlobs(); i++) {
      trackedBlob tb = flob.getTrackedBlob(i);
      float velmult = 1e4;
      float dev = abs(tb.velx) * velmult +   abs(tb.vely) * velmult;



    int videopx = (int)map(tb.cx,0,width,0,videores-1);
    int videopy = (int)map(tb.cy,0,height,0,videores-1);

    color cor = video.get(videopx,videopy); //saber o pixel da posição

   //   println(dev);

      p.addPartsLocVel(tb.cx, tb.cy, tb.velx, tb.vely, dev, velmult,cor);

      //    rect(tb.cx, tb.cy, tb.dimx, tb.dimy );
      //    line(tb.cx, tb.cy, tb.cx + tb.velx * velmult ,tb.cy + tb.vely * velmult );    
      //    String txt = ""+tb.id+" "+tb.cx+" "+tb.cy;
      //    text(txt,tb.cx, tb.cy);
    }

  }


  tint(255,12);
  image(flob.getSrcImage(), 0, 0, width, height);


  p.update();
  p.render();
  

}

void mouseDragged(){
  p.addPartsLoc(mouseX,mouseY,50); 
}


