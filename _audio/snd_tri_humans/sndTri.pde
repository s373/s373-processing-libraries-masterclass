/// agora a class sndTri segue a lógica do jogo, se o som
/// for inferior, altera a dir e não anda, senão anda e não altera a direcção


class sndTri{

  
  PImage img;
  
  // o centro do triângulo
  float px = random(width), py = random(height);
  // o tamanho do triangulo
  float rad=50;
  // a inclinação do triângulo
  float angulo;  

  float speed;
  int mode; // 0 = no audio interaction; 1 = audio interaction; 2 = py audio

  float speedmax,speedmin;
  float radmax,radmin;
  float angmax,angmin;

  color  cfill,cstroke;


  sndTri(){
    
    img = h[(int)random(1,8)];
    
    mode = (int)random(3);//2);
    speed = random(0.5,2.);
    rad = random(20,70);

    //color
    boolean c = (random(1)<0.5);
    cfill=(c)?color(255):color(0);
    cstroke=(c)?color(0):color(15);//(255);


    py = random(200,400);

    // mins e maxs para as escalas
    speedmax = random(10,50.0);
    speedmin = random(0.,0.2);
    radmax = random(55,250);
    radmin = random(5,20);
    angmax = random(1)<0.5? -random(0.01,2.7):random(0.01,2.7);
    angmin = random(-0.001,0.001);    
  }

  void update(){

    rad = map (audio_energy, 0. , 0.1 , radmin,radmax);//50, 250);

    speed = map(audio_energy, 0., 0.1, speedmin, speedmax);// 1.1, 15.);

    if(audio_energy < minSND)
      angulo += map(audio_energy, 0., 0.1, angmin, angmax);//-0.001, 0.3);
    else{
      px = px + cos(angulo-HALF_PI)*speed;
      py = py + sin(angulo-HALF_PI)*speed;
 
   //   angulo += 0.1*map(audio_energy, 0.002, 0.01, angmin, angmax);//-0.001, 0.3);
 
 
    }
    //wrap das coords
    if(px > width)
      px = px - width;
    if(px < 0)
      px += width;

    if(py > height)
      py -= height ;
    if(py < 0)
      py += height ;




  }

  void draw(){

    fill(cfill,20);
    stroke(cstroke,20);

    pushMatrix();

    translate(px,py);

    rotate(angulo);

    tint(255,150);
    image(img, -rad/2, -rad/2, rad, rad);

//    beginShape();
//    vertex(0, -rad);
//    vertex(rad/2, rad);
//    vertex(-rad/2, rad);
//    endShape(CLOSE);    


    popMatrix();

  }



}










