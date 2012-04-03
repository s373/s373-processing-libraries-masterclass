
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



/// game logic
int score;
Goodie pill;
PFont font;



void setup(){

  size(700,700);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);

  background(0);
  px = width/2.0f;
  py = height/2.0f;

  pill = new Goodie();
  // nova fonte
  font = createFont(PFont.list()[1],16);
  textFont(font,16);
}



void draw(){
//  //  background(0);
//  fill(0,10);
//  noStroke();
//  rect(0,0,width,200); // só apaga até à posição 300 y
//
//
//  stroke(255,150);
//
//  // draw the waveforms
//  for(int i = 0; i < in.bufferSize() - 1; i++){
//    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
//    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
//  }


  //desenhar um triângulo a mexer consoante o som


  //   o valor da energia do som vai-se usar para escalar o raio do tri
  //   passado com um filtro lowpass para suavizar as transições

  float rms = in.mix.level();
  float f = 0.1;
  audio_energy = audio_energy * (1.-f) + rms * f;

  // agora o valor do som incrementa a posição do triângulo
  // consoante a sua orientação actual
  if(audio_energy < 0.01) //threshold do som min
    angulo += 0.02;//map(audio_energy,0.,0.2,0.01,0.2);//0.01;

  float walk = map(audio_energy,0.,0.1,0.,25.);

  // + half_pi para corrigir a orientação ao longo da qual o tri anda
  px = px + cos(angulo+HALF_PI)*walk;
  py = py + sin(angulo+HALF_PI)*walk;

  // wrap

  if(px > width)
    px = px - width;
  if(px < 0)
    px += width;

  if(py > height)
    py -= height ;
  if(py < 0)
    py += height ;



  // um triângulo são 3 pontos
  // cada ponto está à mesma distância do centro

  float pt1x,pt1y;
  float pt2x,pt2y;
  float pt3x,pt3y;
  float a; // um angulo

  rad = map (audio_energy, 0. , 0.2 , 50, 150);

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


  //draw goodie & find distance
  pill.draw();

  float distance = dist(px,py,pill.px,pill.py);

  if(distance<(rad + pill.rad*0.25)){ //*0.25 para ser mais perto...
    //touching
    //first draw ellipse to erase current pill
    fill(0);
    ellipse(pill.px,pill.py,pill.rad2,pill.rad2);
    pill.reset(); 
    score++;
    rect(1,height-30,75,30); //clear score
    println("touching pill "+score);
  }


  text("pills "+score,2,height-10);

}


void keyPressed(){
  if(key=='s')
    saveFrame("sndtri4-######.jpg"); 
  if(key=='p')
    rect(1,height-30,75,30); //clear score
  // pill.reset();
  if(key=='b')
    background(0);
}


void stop(){
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}


