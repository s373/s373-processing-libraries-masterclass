float ms = 2.0f;

class Particle
{
  PVector position, velocity;
  PVector inivel;
  float linescal;
  float life,lifedec;
  color cor;

  Particle()
  {
    position = new PVector(random(width),random(height));
    velocity = new PVector(); 
    inivel = new PVector(random(-ms,ms),random(-ms,ms)); 
    linescal = random(1,5);
    life = 255.0f;
    lifedec = random(1,3);
    cor = color(255,255,255);
  }

  void update()
  {
    life-=lifedec;//1.2;
    velocity.x = 25*(noise(cmouseX/10+position.y/100)-0.5);
    velocity.y = 25*(noise(cmouseY/10+position.x/100)-0.5);
    velocity.add(inivel);
    position.add(velocity);

    if(position.x<0)position.x+=width;
    if(position.x>width)position.x-=width;
    if(position.y<0)position.y+=height;
    if(position.y>height)position.y-=height;
  }

  void render()
  {
  //  stroke(255);
  stroke(cor,100);
    line(position.x,position.y,position.x-velocity.x*linescal,position.y-velocity.y*linescal);
  }
}


