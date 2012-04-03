
class Part{
  float x,y,vx,vy, energy;
  boolean active=true;

  Part(float _x, float _y){
    x = _x;
    y = _y;
    vx = random(-5,5);
    vy = random(-5,5);
    energy = 255.0f;    
  } 

  void render(){
    update();
    fill(255,energy);
    ellipse(x,y,20,20); 
  }

  void update(){
    x += vx;
    y += vy;
    vx *= friccao;
    vy *= friccao; 
    energy -= 1.5;
    if (energy<0.)
      active=false;
    
  }


}


