// 3d audio spectrum // andré sier // 20071127

import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

// audio data
Minim minim;
AudioInput audiostream;
FFT fft;
int specsize=0;
int rr;
float orr;

//array data
int ax=128;
int az=64;
float array[][] = new float[ax][az];

//scene
float fov = radians(70.);
float cx = 200.;
float target= cx;

int om=1;
int dom=1;

void setup() {
  size ( 640 , 480, OPENGL);
  minim = new Minim(this);
  audiostream = minim.getLineIn(Minim.STEREO);
  fft = new FFT(audiostream.bufferSize(),audiostream.sampleRate());
  float cameraZ = (height/2.0) / tan(PI * fov / 360.0);
  perspective(fov, (float)width/(float)height, 0.01, cameraZ*10000.0);
  specsize = fft.specSize();
  rr = (int)((float)specsize / ax);
  orr=1.0f/rr;
}

void draw() {
  fft.forward(audiostream.mix);

  background(0);
  camera(cx,-25.,700.,  0., 0., -100.,0.,1.,0.);

  float sum=0.;
  int index=0;

  if(om>0) {
    //copy to firstline
    for(int i=0; i < specsize;i++) {    
      sum+=(fft.getBand(i)*50);
      if(i%rr==0&&i!=0) {
        array[index++][0]= sum * orr;
        sum=0;
      }
    }

    //fifo ter
    for (int j =az-1; j>0;j--)
      for (int i =0; i<ax;i++)
        array[i][j] = array[i][j-1]; 

  }

  stroke(0,255,0,150);

  //draw

  if(dom==0) {
    for (int j =0; j<az;j++) {
      beginShape(LINES);
      for (int i =0; i<ax-1;i++) {       
        vertex((i-ax/2)*3, -(array[i][j]), j*10);
        vertex((i-ax/2)*3, -(array[i+1][j]), j*10);
      }
      endShape();
    }
  } else {

    for (int j =0; j<az;j++) {
      noFill();  
      beginShape();
      for (int i =0; i<ax-1;i++) {       
        vertex((i-ax/2)*3, -(array[i][j]), j*10);
        vertex((i-ax/2)*3, -(array[i+1][j]), j*10);
      }
      endShape();
    }

  }

  if(mousePressed){
    float f1=map(mouseX,0,width,-100,100);
    target = cx+f1;
  }
  cx += (target-cx)*0.07;
}


void keyPressed(){
  if (key == 'o' || key == 'O') {
    om++;
    if(om>1)
      om=0;

  }


  if (key == 'd' || key == 'D') {
    dom++;
    if(dom>1)
      dom=0;

  }


}


void stop() {
  audiostream.close();
  minim.stop();
  super.stop(); 
}


