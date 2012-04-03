



class Goodie{

  float px,py;
  float rad,rad2,crad,radinc;
  boolean active;

  Goodie(){
    rad = random(30,100);
    rad2 = 2*rad;
    px = random(rad2,width-rad2);
    py = random(rad2,height-rad2); 
    active = true;
    crad = 10.;
    radinc = 1.2;
  } 

  void draw(){
    if(active){
      fill(255,255,100,20);
      ellipse(px,py,crad,crad);
      //updated radius
      crad+=radinc;
      if(crad<10||crad>rad2)
        radinc=-radinc;

    }
  }

  void reset(){
    rad = random(30,100);
    rad2 = 2*rad;
    px = random(rad2,width-rad2);
    py = random(rad2,height-rad2); 
    active = true;
    crad = 10.;
    radinc = 0.8;
  }

}




