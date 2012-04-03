// simulações interactivas 2010
// agentes brownianos numa paisagem
// andré sier



Brown elementos[];

void setup(){
  size(1024,600,P2D);
  frameRate(30);
  elementos = new Brown[100];
  for(int i=0;i<elementos.length;i++){
    elementos[i] = new Brown();
  }   
  background(225);
}

void draw(){  
  if(mousePressed){
    dev = map(mouseX,0,width,0.,2.);
    ms = map(mouseY,0,height,0.,5.);
    println(dev+" "+ms);
  }  
  
  for(int i=0;i<elementos.length;i++){
    elementos[i].go();
  }   
  for(int i=0;i<elementos.length;i++){
    for(int j=i+1; j<elementos.length;j++) {      
        elementos[i].touch( elementos[j] );
    }
  }   
}







float dev = 0.7;
float ms = 2.73;
float distmax = 150*150;//250*250;

class Brown{
   float x,y,vx,vy;
   int cor, touch;   
   Brown(){
     x = random(width);
     y = random(height);
     cor = random(1)<0.5 ?  0 :  255;
   }
   void go(){
      touch = 10;
      vx = constrain(vx+random(-dev,dev),-ms,ms); 
      vy = constrain(vy+random(-dev,dev),-ms,ms);   
      x += vx;
      y += vy;
      if(x<0) x+=width;
      if(x>width) x+=-width;
      if(y<0) y+=height;
      if(y>height) y+=-height;
      stroke(cor,150);
      point(x,y);
   }  
   void touch(Brown b) {
      float dx = b.x - x;
      float dy = b.y - y;
      float d = dx*dx+dy*dy;      
      if(d < distmax){
        stroke(b.cor, touch);
        line( b.x, b.y, x, y);      
        touch+=15;
      }   
   }   
}

