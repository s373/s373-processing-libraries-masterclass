// pang // andré sier // 080313
// setas para os lados, espaço dispara


int ground ;

ArrayList b = new ArrayList();
int nb = 1;//20;//1;

Obs[] o = null;
int no = 5;//16;//5;

Heroi h;
long score=0;

ArrayList tiros = new ArrayList();
boolean mayfire=false;

PFont f;
int level = 1;//10;

boolean restart = false;
boolean won = false;
boolean nextlevel = false;
int wontime = 100;

void setup() {
  size(640, 480); 
  ground = height - 50;  
  init_balls();
  init_obs();
  h = new Heroi();
  f = createFont(PFont.list()[1], 70);  
  textFont(f,16);
  rectMode(CENTER);
  ellipseMode(CENTER);
}




void draw() {

   background(150);

  for(int i = 0; i < b.size(); i++) {
    Ball bal = (Ball)b.get(i);
    bal.run(); 
  }

  for(int i = 0; i < no; i++) {
   o[i].draw(); 
  }


  h.run();


  for(int i = 0; i < tiros.size(); i++) {
   Tiro t = (Tiro) tiros.get(i);
   t.run(); 
   if(t.done)
     tiros.remove(i);
  }

  if(mayfire) 
   if(frameCount%10==0){
     Tiro t1 = new Tiro(h.px , h.py - h.rad); 
     tiros.add(t1);
     mayfire=false;
   }
  
  if(restart){
    delay(5000);
    restart=false;
    score=0;
    level=0;
    no=3;
    nb=1;
    setup();
  }

  String stat = "pang level "+level+" h.energy "+h.energy+" balls "+b.size()+" score "+score;
  fill(60,30,0);
  textFont(f,16);
  text(stat,10,height-3);
  
  if(!h.lives) {
    textFont(f,70);
    fill(60,30,0);    
    text("game over", 60,266);
    restart=true;
  }


  if(won) {
    wontime += frameCount;
    nextlevel = true;
    won=false;
  }
  
  if(nextlevel) {
    textFont(f,70);
    fill(60,30,0);    
    int nl = level+1;
    text("you won "+level+ "!  ", 30,250);

    if(frameCount>wontime-50) 
      text("get ready! level "+nl, 30,350);


    if(frameCount>wontime) {
        nextlevel=false;
        won = false;
        wontime = 100;
        level++;
        nb = level * 2;
        no = (int)(level *1.5)  %  16;//abs(10-level) * 3; 
        delay(3000);
        tiros=new ArrayList();
        float prevenergy = h.energy;
        setup();
        h.energy = prevenergy;

    }
    
  }
    

  if(b.size()==0 && h.lives && !nextlevel){
    textFont(f,70);
    fill(60,30,0);    
    text("you won!", 70,250);
    won = true;
  }



  
}


void init_balls(){
  
   b = new ArrayList();
   for(int i = 0; i < nb; i++) {
     Ball bal = new Ball();
     b.add(bal); 
  }
  
}

void init_obs(){
   //init balls
  o = new Obs[no];
  for(int i = 0; i < no; i++) {
   o[i] = new Obs(); 
  }
 
}



void mousePressed(){
  mayfire=true;
}

void keyPressed(){
 if(keyCode==LEFT)
  h.mov=-1;
 if(keyCode==RIGHT)
  h.mov=+1;

 if(key==' ')
  mayfire=true;
  
   if(key=='s')
    saveFrame("bolas_obstaculos-#####.jpg");


  
}

void keyReleased(){
 if(keyCode==LEFT||keyCode==RIGHT)
  h.mov=0;
}

