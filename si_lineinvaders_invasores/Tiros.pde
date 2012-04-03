
class Tiros{
 
   ArrayList tiros = new ArrayList();
  
  
   Tiros(){
     
   }
   
   void add(float x, float y, float a){    
      Tiro t = new Tiro(x,y, a);
      tiros.add(t); 
   }
   
   
   int update(){
   int shootCount = 0;
     
     for(int i=0; i<tiros.size();i++){      
        Tiro t = (Tiro) tiros.get(i); 
        
        t.update();
        
        if( t.y < 0 || t.x < 0 || t.x > width){
                      tiros.remove(i);
//                      i--;
                      continue;            
        }
        
        
        for(int j=0; j<invadersgenerator.invadersAgents.size() ; j++){         
              InvaderSmall inv = (InvaderSmall)  invadersgenerator.invadersAgents.get(j);              

               if( t.test( inv.x, inv.y, inv.invaderSize, inv.invaderSize) ) {
                    
                      hero.explosoesManager.addAt(t.x, t.y);

                      tiros.remove(i);
//                      i--;
                     
                      invadersgenerator.invadersAgents.remove(j);
                 //     j--;        
                 
                      shootCount++;
                      break;
//                      continue;
                      
     
           }
          
        }
       
     }
     return shootCount;
   }
   
   void draw(){
     
        for(int i=0; i<tiros.size();i++){      
              Tiro t = (Tiro) tiros.get(i); 
              t.draw();
        }
     
     
   }
   
  
}


class Tiro {   
   float x, y, speed=-5;
   boolean is = true;
   boolean touch = false;

   float a, vx=0, vy=speed;
  
   Tiro(float _x, float _y){
      x = _x;
      y = _y;
   } 
 
    Tiro(float _x, float _y, float _a){
      x = _x;
      y = _y;
      speed = -5;

      a = _a;
      vx = cos(a)*speed;
      vy = sin(a)*speed;
   } 
   
   
   
  boolean test(float _x, float _y, float dimx, float dimy) {
    touch = false;
//    float dx = x - _x;
//    float dy = y - _y;
    
    if( abs(_x - x) <= dimx && abs(_y - y) <= dimy)
      touch = true;
    

//    if(abs(dx) <= (10+dimx*0.5) && abs(dy) <= (10+dimy*0.5)){ 
//      touch = true;
//    }
    return touch;
  }
   
   void update(){

//       y += speed;

        x += vx;
        y += vy;

//      if(y<0){
//         is = false; 
//      }
   }
   
   void draw(){
//      line(x,y, x, y - speed); 
      line(x,y, x - vx, y - vy); 
   }
  
}
