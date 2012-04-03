class ParticleSystem
{
//  Particle[] particles;
  ArrayList partslist = new ArrayList();
  
  ParticleSystem()
  {
//    particles = new Particle[NUM_PARTICLES];
//    for(int i = 0; i < NUM_PARTICLES; i++)
//    {
//      particles[i]= new Particle();
//    }
    
//    for(int i=0;i<1000;i++){
//      Particle p = new Particle();
//      partslist.add(p);
//    }
    
  }
  
  void addPartsLoc(float x, float y, float dev){
      
    int num = (int)random(10,30);
    for(int i=0;i<num;i++){
      
      Particle p = new Particle();
      p.position.x = x + random(-dev,dev);
      p.position.y = y + random(-dev,dev);
      partslist.add(p);
    }
    
  }

  void addPartsLocVel(float x, float y,  float vx, float vy, float dev, float velmult, color cor){
      
    if(partslist.size()>2500)
      return;
    
    int num = (int)random(10,30);
    for(int i=0;i<num;i++){
      
      Particle p = new Particle();
      p.position.x = x + random(-dev,dev);
      p.position.y = y + random(-dev,dev);
      p.inivel.x = vx *velmult*0.01;//+ random(-dev,dev);
      p.inivel.y = vy *velmult*0.01;//+ random(-dev,dev);
      if(random(1)<0.97)
        p.cor = cor;
      
  
      partslist.add(p);
    }
    
  }

  
  void update()
  {
    for(int i = 0; i < partslist.size(); i++)
    {
      Particle p = (Particle) partslist.get(i);
      p.update();
      if(p.life<0){
          partslist.remove(i);
          i--; 
      }
    }
  }
  
  void render()
  {
    for(int i = 0; i < partslist.size(); i++)
    {
      Particle p = (Particle) partslist.get(i);
      p.render();
    }
  }
}
