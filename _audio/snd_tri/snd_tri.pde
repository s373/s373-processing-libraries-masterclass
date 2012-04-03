
// import a library
import ddf.minim.*;

// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

// o centro do triângulo
float px = 0, py = 300;
// o tamanho do triangulo
float rad=50;
// a inclinação do triângulo
float angulo;
// o valor do audio para ser passado por um filtro
float audio_energy;



void setup(){

  size(700,700);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);

  background(0);
}



void draw(){
  //  background(0);
  fill(0,10);
  noStroke();
  rect(0,0,width,200); // só apaga até à posição 300 y


  stroke(255,150);

  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++){
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }


  //desenhar um triângulo a mexer consoante o som

  // a posição incrementa-se, qd chega ao fim da linha,
  // passa para a linha de baixo, qd passa da linha de baixo,
  // vem para o início, em loop

  px = px + 1.5;
  if(px > width){
    py = py + 100;
    px = 0;
  }
  
  if(py > height)
    py = 300; //zero da posição y


  //   o valor da energia do som vai-se usar para escalar o raio do tri
  //   passado com um filtro lowpass para suavizar as transições
  
  float rms = in.mix.level();
  float f = 0.1;
  audio_energy = audio_energy * (1.-f) + rms * f;
  
//  println("audio energy "+audio_energy);


  // um triângulo são 3 pontos
  // cada ponto está à mesma distância do centro

  float pt1x,pt1y;
  float pt2x,pt2y;
  float pt3x,pt3y;
  float a; // um angulo

  rad = map (audio_energy, 0. , 0.2 , 50, 250);
  angulo += 0.01;
  
  a = HALF_PI + angulo;
  pt1x = cos(a)*rad + px; 
  pt1y = sin(a)*rad + py; 

  a = PI + PI/4 + angulo;
  pt2x = cos(a)*rad + px; 
  pt2y = sin(a)*rad + py; 
 
  a = TWO_PI - PI/4 + angulo;
  pt3x = cos(a)*rad + px; 
  pt3y = sin(a)*rad + py; 
 
 fill(255,100);
 stroke(0,150);
 
 triangle(pt1x,pt1y, pt2x,pt2y, pt3x, pt3y);
 rect(px,py,2,2);

}



void keyPressed(){
  if(key=='s')
    saveFrame("sndtri1-######.jpg"); 
}




