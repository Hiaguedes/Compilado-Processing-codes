public static void printMatriz(int[][] A) { //<>//
  int aRows = A.length;
  int aColumns = A[0].length;
  for (int i=0; i<aRows; i++)
  {
    // Print each row, elements separated by tabs
    for (int j=0; j<aColumns; j++)
      print(A[i][j] +" " );

    // Start a new line at the row's end
    println();
  }

  // Leave a gap after the entire matrix
  System.out.println();
}


public static int[][] comput_val(int[][] A/*mapa */, int custo, PVector objetivo) {

  PVector[] delta = new PVector[4];
  delta[0]=new PVector(-1, 0);//pra cima
  delta[1]=new PVector(0, -1);//pra esquerda
  delta[2]=new PVector(1, 0);//pra baixo
  delta[3]=new PVector(0, 1);//pra baixo

  char[] delta_nome={'^', '<', 'v', '>'};

  boolean change;
  int aRows = A.length;
  int aColumns = A[0].length;
  int[][] valor = new int[aRows][aColumns];
  char[][] regras = new char[aRows][aColumns];


  for (int i=0; i<aRows; i++) {
    for (int j=0; j<aColumns; j++) {
      valor[i][j]=999;
    }
  }
  change=true;
  while (change) {
    change=false;
    for (int i=0; i<aRows; i++) {
      for (int j=0; j<aColumns; j++) {
        if (objetivo.x==i && objetivo.y==j) {
          if (valor[i][j]>0) {
            valor[i][j]=0;
            regras[i][j]='*';
            change=true;
          }
        } else if (A[i][j]==0) {
          for (int a=0; a<delta.length; a++) {
            int x2=i+floor(delta[a].x);
            int y2=j+floor(delta[a].y);

            if (x2>=0 && x2<A.length && y2>=0 && y2<A[0].length && A[x2][y2]==0 ) {
              int v2= valor[x2][y2]+custo;

              if (v2<valor[i][j]) {
                change=true;
                valor[i][j]=v2;
                regras[i][j]=delta_nome[a];
              }
            }
          }
        }
      }
    }
  }

  return valor;
}

int[][] grid= new int[20][20];
class objeto {

  int x, y, ux, uy;

  objeto(int px, int py, int pux, int puy) {
    x=px;
    y=py;
    ux=pux;
    uy=puy;
    int[][] grid= new int[20][20];
  }
  void obst() {
    rect(x, y, 30+30*ux, 30+30*uy); 
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        grid[x][y]=1;
        for (int a=0; a<ux; a++) {
          for (int b=0; b<uy; b++) {
            grid[x+a][y+b]=1;
          }
        }
      }
    }
  }//fim do obst
}
class robozito {
  int x, y;
  PVector location;
  PVector velocity;
  float topspeed;
  // int[][] path=new int[(comput_val(grid,cost,goal)[x][y])+1][2];

  robozito(int x0, int y0) {

    location = new PVector(x0, y0); // Onde o robo começa
    x=x0;
    y=y0;
    velocity =PVector.random2D();
    topspeed = 0.1;
  }
  void update(int[][] path) {
   int b=path.length;
   location.x=path[0][0];
     location.y=path[0][1];
     goal.x=path[1][0];
     goal.y=path[1][1];
   for(int i=0;i<b-1;i++){
     
     
   location.x=path[i][0];
   location.y=path[i][1];
   goal.x=path[i+1][0];
   goal.y=path[i+1][1];
   
    /*grid[path[i+1][0]][path[i+1][1]]=3;
    grid[path[i][0]][path[i][1]]=0;*/
    
   grid[floor(location.x)][floor(location.y)]=3;
   
   
/*   println(location.x,location.y);
   println(goal.x,goal.y);
   println(i);
   println();*/
   
    PVector acceleration = PVector.sub(goal, location);
    // Set magnitude of acceleration
    acceleration.setMag(100);

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
   }
  
  }
  int[][] mov() {
    
    fill(0, 0, 255);
    int x0=x;
    int y0=y;
    
    grid[x][y]=2; 
    int a = comput_val(grid, cost, goal)[x][y+1];
   // println(a, "valor de a");
    int[][] path=new int[(comput_val(grid, cost, goal)[x][y+1])+2][2];

    int i=0;
    path[i][0]=x;
    path[i][1]=y;
   // println(x, y);
   // print(i);
    
    while (comput_val(grid, cost, goal)[x][y]!=0) {
      //for(int i=0;i<comput_val(grid,cost,goal)[x][y];i++){
      // println(i);
      int atual=comput_val(grid, cost, goal)[x][y];
      int dir=comput_val(grid, cost, goal)[x+1][y];
      int esq=comput_val(grid, cost, goal)[x-1][y];
      int baix=comput_val(grid, cost, goal)[x][y+1];
      int cim=comput_val(grid, cost, goal)[x][y-1];

      if (dir<atual && dir<esq && dir<cim && (dir<baix || dir==baix)) {
        x++;
        grid[x][y]=2;
      }

      if (esq<atual && esq<cim && esq<baix && (esq<dir || esq==dir)) {
        x--;
        grid[x][y]=2;
      }

      if (cim<atual && (cim<baix || cim==baix) && (cim<esq || cim==esq) && (cim<dir || cim==dir) ) {

        y--;
        grid[x][y]=2;
      }

      if (baix<atual && baix<cim && (baix<esq || baix==esq) && baix<dir) {
        y++;
        grid[x][y]=2;
      }



      // println();

      //int i=0;

      i++;
      path[i][0]=x;
      path[i][1]=y;
      /*println(path[i][0], path[i][1]);
      println(i);
      println();*/
    }//end do laço
  // printMatriz(path);
    return path;
  }//end do mov
}//end da classe
int i=0;
boolean b=false; 

void printCaminho(int path[][]){
  int[][]t=new int[path.length][path[0].length];
    for(int j=0;j<path[0].length;j++){
         for(int i=0;i<path.length;i++){  
     
     t[i][j]=path[path.length-1-i][j];
       }
      }
  
  PVector velocity=PVector.random2D();
  float topspeed=.0000001;
  PVector location=new PVector(path[i][0],path[i][1]);
  if(i+1==path.length){
    PVector goal=new PVector(path[0][0],path[0][1]);
  }else{
  PVector goal=new PVector(path[i+1][0],path[i+1][1]);
  }
  PVector hist_location=new PVector(path[path.length-1][0],path[path.length-1][1]);
   
  
 if(b==false){
    if(i==0){
   hist_location.x=path[path.length-1][0];
   hist_location.y=path[path.length-1][1];
    location.x=path[0][0];
   location.y=path[0][1];
   goal.x=path[i+1][0];
   goal.y=path[i+1][1];
 }
  
   if(i<path.length-1 && i!=0){
   location.x=path[i][0];
   location.y=path[i][1];
   hist_location.x=path[i-1][0];
   hist_location.y=path[i-1][1];
   goal.x=path[i+1][0];
   goal.y=path[i+1][1];
  
   }
   if(i==path.length-1){
  
     location.x=path[i][0];
   location.y=path[i][1];
   hist_location.x=path[i-1][0];
   hist_location.y=path[i-1][1];
   goal.x=path[0][0];
   goal.y=path[0][1];
     i=0;
   b=true;
   }
 }
 else{
     if(i==0){
   hist_location.x=path[t.length-1][0];
   hist_location.y=path[t.length-1][1];
    location.x=t[0][0];
   location.y=t[0][1];
   goal.x=t[i+1][0];
   goal.y=t[i+1][1];
 }
  
   if(i<t.length-1 && i!=0){
   location.x=t[i][0];
   location.y=t[i][1];
   hist_location.x=t[i-1][0];
   hist_location.y=t[i-1][1];
   goal.x=t[i+1][0];
   goal.y=t[i+1][1];
  
   }
   if(i==t.length-1){
  
     location.x=t[i][0];
   location.y=t[i][1];
   hist_location.x=t[i-1][0];
   hist_location.y=t[i-1][1];
   goal.x=t[0][0];
   goal.y=t[0][1];
     i=0;
   b=false;
   }
  }
   
   
 
    PVector acceleration = PVector.sub(goal,location);
    // Set magnitude of acceleration
    acceleration.setMag(1000);
   
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
    
   stroke(120, 120, 120, 90);
  fill(255,0,0);
  rect(30*location.x,30*location.y,30,30);
  
  fill(0, 0, 255,0);
  stroke(0, 0, 255,0);
  rect(30*hist_location.x,30*hist_location.y,30,30);
  
  delay(150);
   
 i++;
 
println(location.x,location.y);
}

objeto[] o={

  new objeto(2, 1, 2, 10), 
  new objeto(4, 10, 11, 1), 
  new objeto(10, 2, 1, 7), 
  new objeto(10, 11, 1, 5), 
  new objeto(16, 6, 1, 13), 
  new objeto(0, 12, 8, 1), 
  new objeto(7, 6, 9, 1), 
  new objeto(6, 16, 5, 1), 
  new objeto(11, 14, 2, 1)

};


int cost =1;
PVector goal= new PVector(17, 18);
robozito r=new robozito(1, 1);
int[][] a;
void setup() {
  
  comput_val(grid, cost, goal);
 

 //r.update(a);
  size(600, 600); 
  int aColumns=width/30;
  int aRows=height/30;

  for (int i = 0; i < aColumns; i++) {
    for (int j = 0; j < aRows; j++) {
      grid[i][j]=0;
    }
  }
  
  for (int i = 0; i < aColumns; i++) {
    for (int j = 0; j < aRows; j++) {
      grid[0][j]=1;
      grid[i][0]=1;
      grid[aColumns-1][j]=1;
      grid[j][aRows-1]=1; //delimita os limites
    }
  }

  for (int i=0; i<o.length; i++) {
    o[i].obst();
  }
 a=r.mov();
  /*println();
  printMatriz(grid); 
  println();
  printMatriz(comput_val(grid, cost, goal));
 println();
 printMatriz(a);*/

}

void draw() {
   
  stroke(120, 120, 120, 90);
  fill(200);
  for (int x=0; x<width; x+=30) {
    for (int y=0; y<height; y+=30) {
      rect(x, y, 30, 30);
    }
  }

  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 20; j++) {
      if (grid[i][j]==0) {
        fill(200);
        stroke(120, 120, 120, 90);
        rect(30*i, 30*j, 30, 30);
      } else if (grid[i][j]==1) {
        fill(0);
        stroke(0);
        rect(30*i, 30*j, 30, 30);
      } else if (grid[i][j]==2) {
        fill(0, 0, 255,95);
        stroke(0, 0, 255,95);
        rect(30*i, 30*j, 30, 30);
      }else if (grid[i][j]==3) {
        fill(255, 0, 0);
        stroke(255, 0, 0);
        rect(30*i, 30*j, 30, 30);
      }
    }
  }
  if(mousePressed==false){
  printCaminho(a);
  }
  if(mousePressed==true) {
  int x=ceil((mouseX/30))/*-(mouseX%30)*/;
  int y=ceil((mouseY/30))/*-(mouseY%30)*/;
  for (int i=0; i<20; i++) {
    for (int j=0; j<20; j++) {
      if (grid[i][j]>=2) {
        grid[i][j]=0;
      }
    }
  }
  if (grid[x][y]==0) {
    grid[x][y]=1;
    robozito r=new robozito(1, 1);
    //PVector goal= new PVector(17, 18);
    comput_val(grid, cost, goal);
    int[][]a=r.mov();
    println(a.length);
    printMatriz(a);
    printCaminho(a);

  } else {
    grid[x][y]=0;
    robozito r=new robozito(1, 1);
   // PVector goal= new PVector(17, 18);
    comput_val(grid, cost, goal);
    int[][]a=r.mov();
    println(a.length);
    printMatriz(a);
    printCaminho(a);
  }
}

}
