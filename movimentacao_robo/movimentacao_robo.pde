//                 Interface Gráfica para a Iniciação Científica
//-------------Variáveis----------------------------------
Lagann l;
Cell[][] grid;
//int k=0;
objeto[] o= {
  new objeto(6,12,8,1),
  new objeto(9,3,1,5),
  new objeto(6,15,1,6),
  new objeto(9,3,6,1)
};
float a,
v,
m,
b,
vel_hor,
vel_ver,
x0,
y0,
x1,
y1;
int c1,
c2,c3,c4;
int n;
int cols = width/2;
int rows = height/2;
  

//-------------------------------------------------------
//-------------------Bibliotecas-------------------------
//musica,grafico
//-------------------------------------------------------
//---------------------classes---------------------------
//                       ROBO
class Lagann  {
 
  PVector location;
  PVector velocity;
 float ang;
  PVector acceleration;
  float topspeed;
  float x1,y1,xe,ye;
  Lagann(){
  location = new PVector(width/2,110); // Onde o robo começa 
    velocity =PVector.random2D();
    topspeed = 1;
    xe=width/2;
    ye=400;
    
  }
   void update() {  //qq conta 
    
   
    
    PVector obj = new PVector(l.xe+n/2,l.ye+n/2);//para testar só colocar mouseX,mouseY ------- objetivo do robo
    PVector acceleration = PVector.sub(obj,location);
    // Set magnitude of acceleration
    acceleration.setMag(1000);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
     ang=atan((l.location.y - obj.y)/(l.location.x - obj.x));
 

   }
   
  void escada(){
 
     
    n=50;
    
     PVector obj = new PVector(l.xe+n/2,l.ye+n/2);//para testar só colocar mouseX,mouseY ------- objetivo do robo
 strokeWeight(1);
 stroke(0);
 fill(255);
 rect(xe,ye,n+5,n+5);
 fill(0);
 beginShape();
 vertex(xe+5+(n/6),ye+5);
 vertex(xe+n,ye+5);
 vertex(xe+n,ye+n);
 vertex(xe+2*n/3,ye+n);
 vertex(xe+2*n/3,ye+n/3);
 vertex(xe+5+n/6,ye+n/3);
 endShape();
 
 
  
       PVector dist_vetor= PVector.sub(l.location,obj);
  float dist_esc = dist_vetor.mag();
  int c=0;
  //println(dist_esc);
   if(dist_esc<1.5) {
  
   xe=random(100,475);
   ye=random(100,475);
   
  }
 
 
  }
   
  
  void display(){     //qq desenho
   pushMatrix();
 translate(l.location.x,l.location.y);
 
  rotate(ang+radians(90));
//println(location.x,location.y);
    strokeWeight(1);
fill(255,255,255);
stroke(255,0,0);
rect(-15,-15,30,30); //corpo
fill(0,0,0);
rect(-20,-7.5,5,15);//rodas
rect(+15,-7.5,5,15);

//-------------------------------------MARCAÇÕES DO ROBO---------------------------------------
stroke(200,0,0);
fill(255,0,0);//marcação frente vermeho
triangle(5,15,-5,15,0,10);
stroke(0,255,0);
fill(0,255,0);//marcação tras verde
triangle(5,-14,-5,-14,0,-9);
stroke(0,0,255);
fill(0,0,255);//marcação esquerda azul
triangle(-15,5,-15,-5,-10,0);
stroke(255,175,0);
fill(255,255,0);//marcação direita amarelo
triangle(+15,+5,+15,-5,+10,0);
popMatrix();
//-----------------------------------SENSOR----------------------------------------------------------
/*if( (l.location.y)>511){
 stroke(255,0,0,50); //vermelho
 fill(255,0,0,50);
 l.location.y=511;
 l.velocity.y*=-1;
 //delay(500);
} else {
stroke(0,0,255,50);//azul
fill(0,0,255,50);
}
arc(0,+15,100,100,0.33*PI,0.67*PI);//baixo

if( (l.location.y)<90){
 stroke(255,0,0,50); //vermelho
 fill(255,0,0,50);
 l.location.y=90;
 l.velocity.y*=-1;
 //delay(500);
} else {
stroke(0,0,255,50);//azul
fill(0,0,255,50);
}
arc(0,-15,100,100,1.33*PI,1.67*PI);//cima

if( (l.location.x)>511){
 stroke(255,0,0,50); //vermelho
 fill(255,0,0,50);
 l.location.x=511;
 l.velocity.x*=-1;
// delay(500);
} else {
stroke(0,0,255,50);//azul
fill(0,0,255,50);
}
arc(+15,0,100,100,1.833*PI,2.167*PI);//direito

if( (l.location.x)<90){
 stroke(255,0,0,50); //vermelho
 fill(255,0,0,50);
 l.location.x=90;
 l.velocity.x*=-1;
// delay(500);
} else {
stroke(0,0,255,50);//azul
fill(0,0,255,50);
}
arc(-15,0,100,100,0.83*PI,1.167*PI);//esquerdo
 popMatrix();*/
  }
  void mapa(){
   x1=y1=15;
   stroke(0);
   noFill();
  strokeWeight(15);
  rect(x1,y1,width-30,height-30);

 }
 
}
//-----------------------------------------FIM SENSOR-----------------------------------
//objetos na cena 
class objeto extends Lagann{
  PVector location;
  PVector lar_comp;
  int g1,g2,ux,uy;
  
  objeto(int tg1,int tg2,int tux,int tuy){
     
      
      g1=tg1;
      g2=tg2;
      ux=tux;
      uy=tuy;
      location = new PVector(30*g1+15*ux,30*g2+15*uy);
      lar_comp=new PVector(30*ux,30*uy);
  }
  
  
  void obst(){
   
   strokeWeight(0);
   fill(0);
   //teste 
   c1=30*g1;c2=30*g2;c3=30*ux;c4=30*uy;
rect(30*g1,30*g2,30*ux,30*uy); 

  }
  
}
 class Cell extends Lagann {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    angle = tempAngle;
  } 
  
  // Oscillation means increase angle
  void oscillate() {
    angle += 0.2; 
  }

  void display() {
    stroke(200);
    strokeWeight(1);
    // Color calculated using sine wave
    fill(128+127*sin(angle),128+127*sin(angle),128+127*sin(angle),17);
    rect(x,y,w,h); 
  }
}
//----------------------------------------------------
//                     COMEÇO
//----------------------------------------------------
void setup() {
  size(600, 600);
  a = width;
  b = height;
 // m=random(1,10);
  v=random(2,5);
  
  l=new Lagann();
    grid = new Cell[cols][rows];
     for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i*30,j*30,30,30,v*i+(v-1)*j);
    }
     }
}
void draw() {
  background(225,225,220);
   
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Oscillate and display each object
      grid[i][j].oscillate();
      grid[i][j].display();
    }
  }
 
  l.escada();
  l.mapa();
  l.update();
  l.display();
  
  for(int i=0;i<4;i++){
   o[i].obst();
  }
 // PVector dist1 = PVector.sub(l.location,o[1].location);
  //println(dist1);
  float ang;
  PVector obj = new PVector(l.xe+n/2,l.ye+n/2);
  ang=atan((l.location.y - obj.y)/(l.location.x - obj.x));
    // println(ang+radians(90));
   
    
    for(int z=0;z<4;z++ ){ 
       stroke(255,0,0);
     strokeWeight(10);
     
     pushMatrix();
     
     translate(l.location.x,l.location.y);

           
            PVector sens_baix= new PVector((0)* cos(radians(90)+ang) - (65)* sin(radians(90)+ang),
            (0)* sin(radians(90)+ang) + (65)* cos(radians(90)+ang));
       point(sens_baix.x,sens_baix.y);
       
       PVector sens_cima= new PVector((0)* cos(radians(90)+ang) - (-65)* sin(radians(90)+ang),
            (0)* sin(radians(90)+ang) + (-65)* cos(radians(90)+ang));
            
       point(sens_cima.x,sens_cima.y);//0 -65
       
       PVector sens_dir= new PVector((65)* cos(radians(90)+ang) - 0* sin(radians(90)+ang),
            (65)* sin(radians(90)+ang) + 0* cos(radians(90)+ang));
            
       point(sens_dir.x,sens_dir.y);
       
       PVector sens_esq= new PVector((-65)* cos(radians(90)+ang) - 0* sin(radians(90)+ang),
            (-65)* sin(radians(90)+ang) + 0* cos(radians(90)+ang));
            
       point(sens_esq.x,sens_esq.y);
            popMatrix();
            
     
      pushMatrix();
      
 translate(l.location.x,l.location.y);
 //println(l.location.x,o[1].location.x);
  rotate(ang+radians(90));
    
   //PVector[] dist = PVector.sub(l.location,o[z].location);
   PVector[] dist={ new PVector(),new PVector(),new PVector(),new PVector()};
   dist[z]=PVector.sub(l.location,o[z].location);
  
    strokeWeight(5);
    stroke(255,0,0);
       
       
      
     
     
    
  PVector[] obst_rel={ new PVector(),new PVector(),new PVector(),new PVector()};
   obst_rel[z]=PVector.sub(o[z].location,l.location);
   
   
   println(obst_rel[1].x-0.5*o[1].lar_comp.x,obst_rel[1].y-0.5*o[1].lar_comp.y,"---------",sens_dir.x,sens_dir.y);
   strokeWeight(0);
   if((obst_rel[z].x+0.5*o[z].lar_comp.x >= sens_dir.x && obst_rel[z].x+0.5*o[z].lar_comp.x <=0 
       && sens_dir.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_dir.y <= obst_rel[z].y+0.5*o[z].lar_comp.y) ||//robo a direita
       (obst_rel[z].x-0.5*o[z].lar_comp.x <= sens_dir.x && obst_rel[z].x-0.5*o[z].lar_comp.x >=0
       && sens_dir.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_dir.y <= obst_rel[z].y+0.5*o[z].lar_comp.y)||//robo a esquerda
       (obst_rel[z].y+0.5*o[z].lar_comp.y >= sens_dir.y && obst_rel[z].y+0.5*o[z].lar_comp.y <=0
       && sens_dir.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_dir.x <= obst_rel[z].x+0.5*o[z].lar_comp.x)   ||//robo em baixo
       (obst_rel[z].y-0.5*o[z].lar_comp.y <= sens_dir.y && obst_rel[z].y-0.5*o[z].lar_comp.y >=0)
       && sens_dir.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_dir.x <= obst_rel[z].x+0.5*o[z].lar_comp.x){   //robo em cima
        fill(255,0,0,98);
      stroke(255,0,0,98);
     
      arc(15,0,100,100,1.833*PI,2.167*PI);//direito
 
   
     }else{
       fill(0,0,255,17);
      stroke(0,0,255,17);
    
      arc(15,0,100,100,1.833*PI,2.167*PI);//direito
   
     }
     
     if((obst_rel[z].x+0.5*o[z].lar_comp.x >= sens_esq.x && obst_rel[z].x+0.5*o[z].lar_comp.x <=0 
       && (sens_esq.y) >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_esq.y <= obst_rel[z].y+0.5*o[z].lar_comp.y) ||//robo a direita
       (obst_rel[z].x-0.5*o[z].lar_comp.x <= sens_esq.x && obst_rel[z].x-0.5*o[z].lar_comp.x >=0
       && sens_esq.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_esq.y <= obst_rel[z].y+0.5*o[z].lar_comp.y)||//robo a esquerda
       (obst_rel[z].y+0.5*o[z].lar_comp.y >= sens_esq.y && obst_rel[z].y+0.5*o[z].lar_comp.y <=0
       && sens_esq.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_esq.x <= obst_rel[z].x+0.5*o[z].lar_comp.x)   ||//robo em baixo
       (obst_rel[z].y-0.5*o[z].lar_comp.y <= sens_esq.y && obst_rel[z].y-0.5*o[z].lar_comp.y >=0)
       && sens_esq.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_esq.x <= obst_rel[z].x+0.5*o[z].lar_comp.x){   //robo em cima
        fill(255,0,0,98);
      stroke(255,0,0,98);
     
      arc(-15,0,100,100,0.83*PI,1.167*PI);//esquerdo
   
     }else{
       fill(0,0,255,17);
      stroke(0,0,255,17);
      arc(-15,0,100,100,0.83*PI,1.167*PI);//esquerdo
     }
     
     if((obst_rel[z].x+0.5*o[z].lar_comp.x >= sens_cima.x && obst_rel[z].x+0.5*o[z].lar_comp.x <=0 
       && sens_cima.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_cima.y <= obst_rel[z].y+0.5*o[z].lar_comp.y) ||//robo a direita
       (obst_rel[z].x-0.5*o[z].lar_comp.x <= sens_cima.x && obst_rel[z].x-0.5*o[z].lar_comp.x >=0
       && sens_cima.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_cima.y <= obst_rel[z].y+0.5*o[z].lar_comp.y)||//robo a esquerda
       (obst_rel[z].y+0.5*o[z].lar_comp.y >= sens_cima.y && obst_rel[z].y+0.5*o[z].lar_comp.y <=0
       && sens_cima.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_cima.x <= obst_rel[z].x+0.5*o[z].lar_comp.x)   ||//robo em baixo
       (obst_rel[z].y-0.5*o[z].lar_comp.y <= sens_cima.y && obst_rel[z].y-0.5*o[z].lar_comp.y >=0)
       && sens_cima.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_cima.x <= obst_rel[z].x+0.5*o[z].lar_comp.x){   //robo em cima
        fill(255,0,0,98);
      stroke(255,0,0,98);
     
      arc(0,-15,100,100,1.33*PI,1.67*PI);//cima
        
     }else{
       fill(0,0,255,17);
      stroke(0,0,255,17);
     
      arc(0,-15,100,100,1.33*PI,1.67*PI);//cima
      
     }
     
     if((obst_rel[z].x+0.5*o[z].lar_comp.x >= sens_baix.x && obst_rel[z].x+0.5*o[z].lar_comp.x <=0 
       && sens_baix.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_baix.y <= obst_rel[z].y+0.5*o[z].lar_comp.y) ||//robo a direita
       (obst_rel[z].x-0.5*o[z].lar_comp.x <= sens_baix.x && obst_rel[z].x-0.5*o[z].lar_comp.x >=0
       && sens_baix.y >= obst_rel[z].y-0.5*o[z].lar_comp.y && sens_baix.y <= obst_rel[z].y+0.5*o[z].lar_comp.y)||//robo a esquerda
       (obst_rel[z].y+0.5*o[z].lar_comp.y >= sens_baix.y && obst_rel[z].y+0.5*o[z].lar_comp.y <=0
       && sens_baix.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_baix.x <= obst_rel[z].x+0.5*o[z].lar_comp.x)   ||//robo em baixo
       (obst_rel[z].y-0.5*o[z].lar_comp.y <= sens_baix.y && obst_rel[z].y-0.5*o[z].lar_comp.y >=0)
       && sens_baix.x >= obst_rel[z].x-0.5*o[z].lar_comp.x && sens_baix.x <= obst_rel[z].x+0.5*o[z].lar_comp.x){   //robo em cima
        fill(255,0,0,98);
      stroke(255,0,0,98);
      arc(0,15,100,100,0.33*PI,0.67*PI);//baixo
      
   
     }else{
       fill(0,0,255,17);
      stroke(0,0,255,17);
      arc(0,+15,100,100,0.33*PI,0.67*PI);//baixo
    
     }
   stroke(0);
   
   rotate(-(radians(90)+ang));
   line(0,0,obst_rel[z].x,obst_rel[z].y);
   
    popMatrix();
    strokeWeight(0);
    stroke(255,0,0);
    //line(l.location.x,l.location.y,o[z].location.x,o[z].location.y);
   
    line(l.location.x,l.location.y,22.5,l.location.y);
    line(l.location.x,l.location.y,l.location.x,22.5);
   
    line(l.location.x,l.location.y,l.location.x,height-22.5);
    line(l.location.x,l.location.y,width-22.5,l.location.y);
   
    
           
    }
    
}