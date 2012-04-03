class plane{
  float x,y,z,s; //pos e vel
  float rx,ry;
  float dimx,dimy; 
  PImage img;

  int videohead;

  plane(){
    reset();
  }

  void reset(){
    initCoords();
    setImg();    
  }

  void initCoords(){
    float w = width*3;
    float h = 2000;
    x = random(-w,w);
    y = random(-h,-h/2);
    z = -5 + ((int)random(0,5)) * -2000;///random(-1000,-10);
    s = random(1,2.5)*25;///random(2,10)*10;//random(10,50);
    rx = random(-0.3,0.3);//random(TWO_PI);
    ry = random(-0.5,0.5);//random(TWO_PI);

    dimy = random(100,200);
    dimx = dimy *16./9.;    
  }

  void setImg(){
    videohead = (int)random(frames.length);
  //  img = frames[(int)random(frames.length)];     
  }


  void render(){
    
    videohead=(videohead+1)%frames.length;
    img = frames[videohead];     
    
    //update
    y += s;
    if(y>700){
      reset();
    }

    //draw
    pushMatrix();
    translate(x,y,z);
    rotateX(rx);
    rotateY(ry);
    beginShape();
    texture(img);
    vertex(-dimx,-dimy,0,0);
    vertex( dimx,-dimy,img.width,0);
    vertex( dimx, dimy,img.width,img.height);
    vertex(-dimx, dimy,0,img.height);
//   vertex(-dimx,-dimy);
//    vertex( dimx,-dimy);
//    vertex( dimx, dimy);
//    vertex(-dimx, dimy);
    endShape(CLOSE);
    popMatrix();     



  }



}


