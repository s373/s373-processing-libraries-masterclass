float g = 0.05;



class Ball{
 int px,py;
 boolean on=false;
 float velx, vely, d;
 float rad=random(20,70);//20;
 
  Ball(){
   px = (int)random(width); 
   py = 20;
   velx = random(-5,5);
   vely = -random(1,2);// random(2,5);//random(5,10);
   desenha();
  }

  Ball(int xx,int xy, int side, float radd){
   px = xx; 
   py = xy;
   velx = (side>0)?random(2,5):-random(2,5);
   vely = -random(1,5);//random(5,10);
   rad = radd;
   desenha();
  }

  
  void run(){
        vely+=g;//gravit
    // go coords with vel
    px += velx;
    py += vely;
 
 
    //out leftright corner
 //   if(px < 0 || px > width)     {      velx = -velx;    }
    //out updown corner

//    if(py < 0 || py > ground) {      vely = -vely;    }

    if( py > ground) {      vely = -vely;    }

    if(py > ground)
      py = ground;
  
    if(px<0) {
      px += 640-rad;//600-rad//width; 
     // velx -= 0.1;
    }

    if(px>width) {
      px -= 640-rad; //=0;//Mwidth; 
     // velx += 0.1;
    }
 
/* 
test obstacles
*/
  
      test_obstacles();
      
  
   
    if(on) {
      //step back
     px -= velx*0.8; 
     py -= vely*0.8;
     
     velx = -velx * 0.9;
     vely = -vely * 0.9;
    }
    
    
    if(abs(velx)<=1)
      velx = random(-5,5);

    
    
    desenha();
    
  }
  
  
  void desenha(){
    if(on)
      fill(0);
    else
      fill(255);
     float rad2 = rad*2;
    ellipse(px,py,rad2,rad2);
    
    rect(px,py,2,2);
    
    
  }
   
   
   void test_obstacles(){
    boolean in=false; 

     for(int i = 0; i < no; i++) {
       float d = dist(px,py,o[i].px,o[i].py);
       float sumrad = rad + o[i].rad;
       
       if( d < sumrad) {
        in = true;
         break; 
       }
            
      }
 
 
     if(in){
       on = true;
     } else {
       on = false; 
     }
 
     
   }
   
  
}

