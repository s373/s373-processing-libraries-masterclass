class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro
  float cdev = 20; //desvio do centro
  float fx,fy; // uma força

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev)); 
    }
  } 

  SysPart(int num, float x, float y, color c){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev), c); 
    }

  }

  void setPos(float x, float y){
    cx = x;
    cy = y; 
  }

  void setPosForce(float x, float y, float px, float py){
    cx = x;
    cy = y; 
    this.fx = (x - px)*0.1;
    this.fy = (y - py)*0.1;
  }


  void reIgnite(){
    for(int i = 0; i < p.length; i++) {
      if(p[i].energy < 0){
        p[i].energy = 255;
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy);
        float force = (abs(fx)+abs(fy)) * 10.;
        p[i].make_rnd_normalized_velocity(random(force));
      }
    }    
  }


  void update(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy > 0)
        p[i].update();

      //      if(p[i].energy < 0){
      //        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova força
      //        p[i].energy = 255;  //energia a 255 de novo
      //        float force = ( (frameCount*0.1) % 100);
      //        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      //      } 

    }

  }


  void draw(){

    for(int i = 0; i < p.length; i++) {
      if(p[i].energy>0)
        p[i].draw();
    }
  }


}




