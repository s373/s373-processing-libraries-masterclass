
class Tiro{
 float px,py;
 boolean done=false;

 Tiro (float xx, float xy ){
  px = xx;
  py = xy; 
 }
  
  void run(){
    
    if(py < 0)
      done=true;
    
    
   py -= 2.;
  
    //test balls
    int maxloop = b.size(); //changes
    
    for(int i = 0; i < maxloop ; i++) {
       Ball bal = (Ball) b.get(i);
       float d = dist (px,py, bal.px, bal.py);

       if ( d < bal.rad) {//hit

         if(bal.rad > 20) { //spwan 2
           Ball b1 = new Ball(bal.px,bal.py,-1,bal.rad*0.5);
           Ball b2 = new Ball(bal.px,bal.py, 1,bal.rad*0.5);
           b.add(b1);
           b.add(b2);
           
           score += bal.rad;
           b.remove(i);
           maxloop = b.size();
           
         } else {
           b.remove(i);
           score+=bal.rad; //score + rad
           maxloop = b.size();
         }
         
         //either way, remove thisone
         done=true;
       
       }
    }
 
 
 
 //test obstacles
    for(int i = 0; i < o.length ; i++) {
       Obs ob = o[i];
       float d = dist (px,py, ob.px, ob.py);

       if ( d < ob.rad) {//hit
         done=true;
       
       }
    }
 
 
 
 
 
       desenha();
       
    }
    
   
   void desenha(){
    line(px,py+5,px,py-5); 
     
   }
   
   
}

