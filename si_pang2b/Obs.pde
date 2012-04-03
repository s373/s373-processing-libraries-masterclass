class Obs{
 int px,py,rad;
 int om=0;
 float fx=random(0.5,2);
  float fy=random(0.5,2);

  Obs(){
   px = (int)random(width);
   py = (int)random(100,height-100);//height - height/4;//(int)random(height);
   rad = (int)random(10,30);
   om = (random(1)<0.3)?(int)random(1,7):0;
  } 
  
  
  void draw(){
   if(om>0){
     if(om==1||om==3){
       px += fx;
       if(px>width)
         px=0;
     }
     if(om==2||om==3){
       py += fy;
       if(py>height)
         py=0;
     }

     if(om==4||om==6){
       px -= fx;
       if(px<0)
         px=width;
     }
     if(om==5||om==6){
       py -= fy;
       if(py<0)
         py=height;
     }

       
    
   } 
    
    float rad2 = rad*2;
    fill(50,0,0);
   rect(px,py,rad2,rad2); 
  }
  
  
  
}

