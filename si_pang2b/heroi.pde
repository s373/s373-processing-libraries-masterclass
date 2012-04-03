


class Heroi {
  float px, py;
  float rad;
  float energy=255;
  boolean lives=true;
  int mov=0;
  
  Heroi() {
    rad = 10;
    px = width/2;
    py = height-rad*4;
    }
  
  void run() {
   
   if(lives) {
    
    boolean hit = test_obstacles();
    if(hit==false) { 
      px += mov*2;// map (mouseX, 0, width, -10.0 , 10.) ;    
    } else {
      energy -= 5;
      if (energy<10)
        lives=false;
      }
    
    if(px<0)
      px=width-1;
      
    if(px>width)  
      px=1;
    
    
    test_obstacles();
    
    
    }
    
    
      desenha();
    
    }
 
 
   boolean test_obstacles(){
 
     boolean in=false; 

     for(int i = 0; i < b.size(); i++) {
       Ball bal = (Ball)b.get(i);
       
       float d = dist(px,py,bal.px,bal.py);
       float sumrad = rad + bal.rad;
       
       if( d < sumrad) {
        in = true;
         break; 
       }
            
      }
 
    return in;

     }
 
 
   void desenha() {
     float r2 = rad*2;//0.5;
     float r4 = rad;//0.25;
    fill(60,30,0,energy); 
    rect(px,py,r2,r2);
    rect(px,py-r2,r4,r4);    

  //  ellipse(px,py,r2,r2); //player active area
    
    
    }

 
 
 
 
 
 
 
  
  }

