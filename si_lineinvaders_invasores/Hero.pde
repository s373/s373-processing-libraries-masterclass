
class Hero {
 
   InvaderSmall inv, invLife;
   int score = 0;
   boolean left, right, fire, doFire;
   Tiros tiros;
   Explo explosoesManager;
   int lifes = 3;
   int lifeTimer = 100;
   int mode = 1; //0 = dead
   
   float miraX,miraY;
  
   Hero(){
     inv = new InvaderSmall();
     inv.build();
     inv.x = width/2;
     inv.y = height-inv.invaderSize;

     invLife = new InvaderSmall(inv); //ja com invader size...
     
     tiros = new Tiros();
     explosoesManager = new Explo();
     
     miraX = width/2;
     miraY = height/2;
   }
  
  
   void takeLife(){
       mode = 0;
       explosoesManager.addAt(inv.x, inv.y);     
   }
  
   void update(){
     
     if(mode > 0) {     
       
            miraX += (mouseX-miraX)*0.025f;
            miraY += (mouseY-miraY)*0.025f;
       
            int a = 2;
            if(left){
               inv.x -= a;
               if(inv.x < inv.invaderSize){
                   inv.x = inv.invaderSize;
               }
            } 
            if(right){
               inv.x += a;
               if(inv.x > width-inv.invaderSize){
                   inv.x = width-inv.invaderSize;
               }
            }       
            if((fire||doFire) && frameCount % 10 == 0){
               doFire = false;      
               float angle = atan2( -(miraY-inv.y), -(miraX-inv.x) );
               tiros.add(inv.x, inv.y, angle);   
               playShoot();      
            }
            
            score += tiros.update();
     } else {
      
       
         lifeTimer--;
         if(lifeTimer == 0){
          
            lifeTimer = 100;
            lifes--;
            
            mode = 1;

            if(lifes < 0){
               gameOver = true; 
               playGameOver();
            } else {
  
                invadersgenerator.invadersAgents.clear();
            
                tiros.tiros.clear();
                
                hero.doFire = false;
                
            }
           
           
         }
         
       
     }
      
      
      
      explosoesManager.update();
      
   }
   
   
   void draw(){
    
      noStroke();
      if(mode>0)
        inv.draw(inv.x, inv.y);
      stroke(0);
      tiros.draw(); 
      explosoesManager.draw();


      fill(0);
      text("score:    "+nf(score,5), 5, 16);
      text("invaders: "+nf(invadersgenerator.invadersAgents.size(),5), 2,30);

      noStroke();
      for(int i=0; i<lifes; i++){       
         invLife.draw( i*35+25, 40);        
      }

      noFill();stroke(0);
      ellipse(miraX, miraY, 5, 5);
     
   }
     
  
}
