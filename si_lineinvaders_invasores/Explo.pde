class Explo {
  
    ArrayList explosoes = new ArrayList();
 
  
    Explo(){      
    }
    
    void addAt(float x, float y){    
       playBlast() ;
       int n = (int) random(10,20);
       for(int i=0; i<n; i++){
          ExploLine e = new ExploLine(x,y, TWO_PI/(float)n * i);
          explosoes.add(e);
       } 
      
    }
    
    void update(){
      for(int i=0; i< explosoes.size(); i++){       
          ExploLine e = (ExploLine) explosoes.get(i);
          e.update();
          if(e.life<=0){
            explosoes.remove(i);
            i--;
          }        
      }
      
    }
    
    void draw(){
      for(int i=0; i< explosoes.size(); i++){       
          ExploLine e = (ExploLine) explosoes.get(i);
          e.draw();
      }            
    }
  

}



class ExploLine {
   
 float x, y, a, vx, vy, life=1;

  ExploLine(float _x, float _y, float _a){
     x = _x;
     y = _y;
     a = _a;
     float s = random(1,3);
     vx = s*cos(a);
     vy =  s*sin(a);
  }
   
  void update(){
     x+=vx;
     y+=vy;
     life-=0.01; 
  }
  void draw(){

    line(x,y,x-vx, y-vy);
    
  }
   
  
}
