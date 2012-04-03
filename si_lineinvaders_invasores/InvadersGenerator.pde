

class InvadersGenerator {  
   ArrayList invadersAgents = new ArrayList();
   int rate = 60;
   int rateMax = 120;
   int rateMin = 30;
   int rateDir = -5;
    
   InvadersGenerator(){
     
   }
   
   void changeRate(){
      rate += rateDir;
      if(rate <= rateMin || rate >= rateMax)
        rateDir = -rateDir;
   }
   
   void checkAddAgents(){
       if(frameCount % rate == 0){ 

           if(random(1)<0.25) {
              changeRate();    
           }
         
         
           addAgent (new InvaderSmall() );
            
       }
   }
   
   void addAgent(InvaderSmall inv) {
          
     inv.x = random(width/7, width-width/7);
     inv.y = 0;
     
     InvaderSmall newinv = new InvaderSmall(inv);     

     invadersAgents.add(newinv);
     
   }
   
   void update(){
     
     checkAddAgents();     
     for(int i=0; i<invadersAgents.size(); i++){     
         InvaderSmall inv = (InvaderSmall)  invadersAgents.get(i);
         inv.update();
         
     }
     
   }
  
   void draw(){

     for(int i=0; i<invadersAgents.size(); i++){     
         InvaderSmall inv = (InvaderSmall)  invadersAgents.get(i);
         inv.draw(inv.x, inv.y);
     }
     
     
   }
  
}
