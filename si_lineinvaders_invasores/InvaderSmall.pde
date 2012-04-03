


class InvaderSmall {

  boolean bits[];
  int dimx, dimy;
  float scalex, scaley;
  float prob;
  String name="untitled-0";
  float invaderSize = 25.0f;

  float x, y, s;

  int idnum = -1;
  boolean showId = false;

  InvaderSmall() {
    dimx = 5;//8;//4;
    dimy = 10;//16;//8;
    prob = 0.52f;
 
    initPos();   
    build();
  }
  
  
  InvaderSmall(InvaderSmall in){
     x = in.x;
     y = in.y;
     s = in.s;
     dimx = in.dimx;
     dimy = in.dimy;
     prob = 0.52f;
     invaderSize = 20;
     build();
     for(int i=0; i<bits.length;i++){
       bits[i] = in.bits[i];
     }

  }
  

  void update(){
    y += s;
    if( y > height) {
       hero.takeLife();
       hero.explosoesManager.addAt(x, y);
       initPos(); 
    }

  }

  void initPos(){
     x = random(width/5, width-width/5);
     y = 0;
     s = (int)random(1,4);
  }

  void setDim(int x, int y) {
    dimx = x; /// halfdim
    dimy = y; 
    build();
  }





  String getBits() {
    String genome = "";
    for(int i=0; i<bits.length;i++) {
      if(bits[i]==true)
        genome+= "1";
      else
        genome+= "0";
    }
    return genome;
  }
  
  void build() {

    
    //    float invaderSize = 16.0f;
    scalex = (float)invaderSize / (float)dimx / 2.0f;
    scaley = (float)invaderSize / (float)dimy ;
    
    bits = new boolean[dimx*dimy];
    for(int i=0,idx=0; i<dimx; i++) {
      for(int j=0; j<dimy; j++) {
        bits[idx] = random(1)<prob? true:false;
        idx++;
      }
    }
  }


  void draw(float x, float y) {
    
    pushMatrix();
    translate(x,y);
    
    for(int i=0, idx=0; i<dimx; i++) {
      for(int j=0; j<dimy; j++) {
        
        if(bits[idx]==true)
          fill(255);
        else
          fill(0);

        rect (  (i+0.5) * scalex, (j+0.5) * scaley, scalex, scaley );
        rect (  (2*dimx-i-0.5) * scalex, (j+0.5) * scaley, scalex, scaley );
        idx++;
      }
    }
    

    popMatrix();
  }


}

