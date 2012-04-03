
// import a library
import ddf.minim.*;

// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

// o valor do audio para ser passado por um filtro
float audio_energy;

// a array de triângulos
sndTri  tris[];
int numtris = 100;

float minSND = 0.01; //0.001


void setup(){

  size(screen.width,screen.height);
//  size(700,700);

  
  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);


  // load images
  loadImages();


  tris = new sndTri[numtris];
  for(int i=0; i<tris.length;i++){
     tris[i] = new sndTri(); 
  }

  background(0);
  
    noCursor();

}



void draw(){
 background(0);

//  fill(0,25);
//  noStroke();
//  rect(0,0,width,200); // só apaga até à posição 200 y
//
//
//  stroke(255,150);
//
//  // draw the waveforms
//  for(int i = 0; i < in.bufferSize() - 1; i++){
//    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
//    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
//  }


  //   o valor da energia do som vai-se usar para escalar o raio do tri
  //   passado com um filtro lowpass para suavizar as transições

  float rms = in.mix.level();
  float f = 0.1;
  audio_energy = audio_energy * (1.-f) + rms * f;

//println(audio_energy);
 
   // renderizar todos os triangulos
 
 
   for(int i=0; i<tris.length;i++){
     tris[i].update();
     tris[i].draw(); 
     
     // check distance & line if < thresh
      for(int j=i+1; j<tris.length;j++){
       float d = abs(tris[i].px-tris[j].px) + abs(tris[i].py-tris[j].py); 
       if(d < 100){
        stroke(tris[i].cfill,12);
        line(tris[i].px,tris[i].py,tris[j].px,tris[j].py);
       }
      }
  }

 

}



void keyPressed(){
  if(key=='s')
    saveFrame("sndhumans-######.jpg"); 
}





