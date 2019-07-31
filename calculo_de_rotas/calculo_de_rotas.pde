public static void printSentido(char[][] A){
      int aRows = A.length;
        int aColumns = A[0].length;
        for (int i=0; i<aRows; i++)
    {
      // Print each row, elements separated by tabs
      for (int j=0; j<aColumns; j++)
        System.out.print(A[i][j]+"   " );

      // Start a new line at the row's end
      System.out.println();
    }

    // Leave a gap after the entire matrix
    System.out.println();
    
      }
      
      public static void printMatriz(int[][] A){
      int aRows = A.length;
        int aColumns = A[0].length;
        for (int i=0; i<aRows; i++)
    {
      // Print each row, elements separated by tabs
      for (int j=0; j<aColumns; j++)
        System.out.print(A[i][j] +"   " );

      // Start a new line at the row's end
      System.out.println();
    }

    // Leave a gap after the entire matrix
    System.out.println();
    
      }
public static char[][] comput_sen(int[][] A,int custo,PVector objetivo){
  
  PVector[] delta = new PVector[4];
     delta[0]=new PVector(-1,0);//pra cima
     delta[1]=new PVector(0,-1);//pra esquerda
     delta[2]=new PVector(1,0);//pra baixo
     delta[3]=new PVector(0,1);//pra baixo
     
   char[] delta_nome={'^','<','v','>'};
  
  boolean change;
  int aRows = A.length;
  int aColumns = A[0].length;
  int[][] valor = new int[aRows][aColumns];
  char[][] regras = new char[aRows][aColumns];
  
  
  for(int i=0;i<aRows;i++){
    for(int j=0;j<aColumns;j++){
    valor[i][j]=99;
    }
  }
 change=true;
 while(change){
   change=false;
   for(int i=0;i<aRows;i++){
    for(int j=0;j<aColumns;j++){
    if(objetivo.x==i && objetivo.y==j){
      if(valor[i][j]>0){
        valor[i][j]=0;
        regras[i][j]='*';
        change=true;
      }
    }else if(A[i][j]==0){
      for(int a=0;a<delta.length;a++){
        int x2=i+floor(delta[a].x);
        int y2=j+floor(delta[a].y);
        
        if(x2>=0 && x2<A.length && y2>=0 && y2<A[0].length && A[x2][y2]==0){
           int v2= valor[x2][y2]+custo;
        
        if(v2<valor[i][j]){
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
  
  return regras;
}

public static int[][] comput_val(int[][] A,int custo,PVector objetivo){
  
  PVector[] delta = new PVector[4];
     delta[0]=new PVector(-1,0);//pra cima
     delta[1]=new PVector(0,-1);//pra esquerda
     delta[2]=new PVector(1,0);//pra baixo
     delta[3]=new PVector(0,1);//pra baixo
     
   char[] delta_nome={'^','<','v','>'};
  
  boolean change;
  int aRows = A.length;
  int aColumns = A[0].length;
  int[][] valor = new int[aRows][aColumns];
  char[][] regras = new char[aRows][aColumns];
  
  
  for(int i=0;i<aRows;i++){
    for(int j=0;j<aColumns;j++){
    valor[i][j]=99;
    }
  }
 change=true;
 while(change){
   change=false;
   for(int i=0;i<aRows;i++){
    for(int j=0;j<aColumns;j++){
    if(objetivo.x==i && objetivo.y==j){
      if(valor[i][j]>0){
        valor[i][j]=0;
        regras[i][j]='*';
        change=true;
      }
    }else if(A[i][j]==0){
      for(int a=0;a<delta.length;a++){
        int x2=i+floor(delta[a].x);
        int y2=j+floor(delta[a].y);
        
        if(x2>=0 && x2<A.length && y2>=0 && y2<A[0].length && A[x2][y2]==0){
           int v2= valor[x2][y2]+custo;
        
        if(v2<valor[i][j]){
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

      public static void main(String args[]){
 int[][] grid= new int[20][20];
      for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 20; j++) {
      grid[i][j]=0;
    }
  }
   for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 20; j++) {
    grid[0][j]=1;
    grid[i][0]=1;
    grid[19][j]=1;
    grid[j][19]=1; //delimita os limites
    
    
    }
   }
   
  for(int i=0;i<8;i++){
    for(int j=0;j<1;j++){
      grid[15+j][6+i]=1;
    }
  }
  
  for(int i=0;i<1;i++){
    for(int j=0;j<5;j++){
      grid[3+j][9+i]=1;
    }
  }
  
  for(int i=0;i<1;i++){
    for(int j=0;j<5;j++){
      grid[15+j][6+i]=1;
    }
  }
  
  for(int i=0;i<6;i++){
    for(int j=0;j<1;j++){
      grid[3+j][9+i]=1;
    }
  }
  
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      grid[9+j][1+i]=1;
    }
  }
 int cost=1 ;
PVector goal=new PVector(/*grid.length-1*/1,/*grid[0].length-1*/1);
PVector inicio=new PVector(0,0);
  
      
     printSentido(comput_sen(grid,cost,goal));
     println();
     printMatriz(comput_val(grid,cost,goal));
     println();
     printMatriz(grid);
     
   
      }
