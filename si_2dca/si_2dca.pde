
/**
2d cellular automata explorer
press ' '(space) to reset background and change cellular rule
press 'r' to change but cellular rule

*/

// 2d totalitarian cellular automata

// sarts as game of life
// neighbors is different, rules are 10bit wide
// this is next next neibors



int[][] grid, futuregrid;

int numbit=26;
int[] rules ={ 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1 };//{ 1, 0, 1, 0, 0, 1, 0 ,0 };// {0,1,0,1,1,0,0,1 };


//  0 0 0 1 0 1 1 1 0 0 click
//  0 1 0 0 1 1 0 1 0 1 
//  1 1 1 0 0 0 0 1 0 1
// rules: 1 0 1 1 0 1 0 1 0 0

// fades  rules: 1 0 1 1 0 1 0 1 0 0

void setup() {
 size(500,500);
 frameRate(8);
 grid = new int[width][height]; 
 futuregrid = new int[width][height];
 
  grid[width/2][height/2]=1;

 background(0);
}

void draw(){
  
  for(int x=3; x<width-3; x++)
      for(int y=3; y<height-3; y++){
        
         int cc = nextnextneib(x,y);//neighbors(x,y);//star(x,y);
         
         if(rules[cc]==0) {
          futuregrid[x][y]=0;
          set(x,y,color(0)); 
         } else if(rules[cc]==1) {
          futuregrid[x][y]=1;
          set(x,y,color(255)); 
           
         }
         
      }



    //swap grids
    int[][] temp = grid;
    grid = futuregrid;
    futuregrid = temp;
  
}

// count


int nextnextneib(int x, int y){
  
  return ( grid[x][y] +
          grid[x][y-1] + //north
          grid[x+1][y-1] + //northeast
          grid[x+1][y] + //east
          grid[x+1][y+1] + //southeast
          grid[x][y+1] + //south
          grid[x-1][y+1] + //southwest
          grid[x-1][y] + //west
          grid[x-1][y-1] +  //northwest

          grid[x][y-2] + //north
          grid[x+2][y-2] + //northeast
          grid[x+2][y] + //east
          grid[x+2][y+2] + //southeast
          grid[x][y+2] + //south
          grid[x-2][y+2] + //southwest
          grid[x-2][y] + //west
          grid[x-2][y-2] + //northwest

          grid[x][y-3] + //north
          grid[x+3][y-3] + //northeast
          grid[x+3][y] + //east
          grid[x+3][y+3] + //southeast
          grid[x][y+3] + //south
          grid[x-3][y+3] + //southwest
          grid[x-3][y] + //west
          grid[x-3][y-3]  //northwest



          );
  
}





int nextneib(int x, int y){
  
  return ( grid[x][y] +
          grid[x][y-1] + //north
          grid[x+1][y-1] + //northeast
          grid[x+1][y] + //east
          grid[x+1][y+1] + //southeast
          grid[x][y+1] + //south
          grid[x-1][y+1] + //southwest
          grid[x-1][y] + //west
          grid[x-1][y-1] +  //northwest

          grid[x][y-2] + //north
          grid[x+2][y-2] + //northeast
          grid[x+2][y] + //east
          grid[x+2][y+2] + //southeast
          grid[x][y+2] + //south
          grid[x-2][y+2] + //southwest
          grid[x-2][y] + //west
          grid[x-2][y-2]  //northwest



          );
  
}




int neighbors(int x, int y){
  
  return ( grid[x][y] +
          grid[x][y-1] + //north
          grid[x+1][y-1] + //northeast
          grid[x+1][y] + //east
          grid[x+1][y+1] + //southeast
          grid[x][y+1] + //south
          grid[x-1][y+1] + //southwest
          grid[x-1][y] + //west
          grid[x-1][y-1]  //northwest
          );
  
}

int star(int x,int y) {
   return ( grid[x][y] +
          grid[x][y-1] + //north
          grid[x+1][y] + //east
          grid[x][y+1] + //south
          grid[x-1][y]  //west
          );
 
  
}


void mousePressed(){
  int x = constrain(mouseX,0,width);
  int y = constrain(mouseY,0,height);
  grid[x][y] = 1;
}

void mouseDragged(){
  int x = constrain(mouseX,0,width);
  int y = constrain(mouseY,0,height);
  grid[x][y] = 1;
}


void keyPressed(){
 if(key==' ') {
  zerospace();
 }
 if(key=='r')
   setrule();
}


void setrule(){
    print("rules: ");
   for(int i=0;i<numbit;i++){
    rules[i] = (int)random(2);
    print(rules[i]+ " ");
  }
 
}

void zerospace(){
  
   background(0);
   print("rules: ");
   for(int i=0;i<numbit;i++){
    rules[i] = (int)random(2);
    print(rules[i]+ " ");
  }
  println();
  
 for(int x=0; x<width;x++ ) 
   for(int y=0; y<height;y++){
    grid[x][y]=0;
    futuregrid[x][y]=0;
    
   }
  
  grid[width/2][height/2] = 1; // should be width, who cares 
   
}


