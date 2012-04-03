
PImage h[] = new PImage[8];
PImage m[] = new PImage[8]; // humanos e mascaras


void loadImages(){
 
  // retirado do exemplo Alphamask
  
 for(int i=1; i < 8; i++) {
   h[i] = loadImage("humanmasks/h"+i+".jpg");
   m[i] = loadImage("humanmasks/m"+i+".jpg");
   h[i].mask(m[i]);
   println("acabei de ler "+"humanmasks/h"+i+".jpg e sua máscara m"+i+".jpg");
 } 

  
}
