//                 Interface Gráfica para a Iniciação Científica
//-------------Variáveis----------------------------------
Lagann l;
Cell[][] grid;
objeto[] o = {
  new objeto(6,12,8,1),
  new objeto(18,3,1,8)
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
y1,
c1,
c2;
int n;
int cols = width/2;
int rows = height/2;
  int y;

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
 float px=random(200,300);
 float py=random(100,300);
    float xc=width/2;
    float yc=height/2;
  
  Lagann(){
  location = new PVector(random(300,400),random(-300,-300)); // Onde a escada
    velocity =PVector.random2D();
    topspeed = 1;
   
      
  }
   void update() {  //qq conta 
    
   
    
    PVector obj = new PVector(l.xc-n/2,l.yc-n/2);//para testar só colocar mouseX,mouseY ------- objetivo do robo
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
println(l.xc,l.yc);

   }
   
  void escada(){
 
     
    n=50;
    
     PVector obj = new PVector(l.xc-n/2,l.yc-n/2);//para testar só colocar mouseX,mouseY ------- objetivo do robo
 
 strokeWeight(1);
 stroke(0);
 fill(255);
 rect(location.x,location.y,n+5,n+5);
 fill(0);
 strokeWeight(0);
 beginShape();
 vertex(location.x+5+(n/6),location.y+5);
 vertex(location.x+n,location.y+5);
 vertex(location.x+n,location.y+n);
 vertex(location.x+2*n/3,location.y+n);
 vertex(location.x+2*n/3,location.y+n/3);
 vertex(location.x+5+n/6,location.y+n/3);
 endShape();
 
 
  
       PVector dist_vetor= PVector.sub(l.location,obj);
  float dist_esc = dist_vetor.mag();
  //println(dist_esc);
   if(dist_esc<1.5) {
   //topspeed = 3;
   
   location.x=random(0);
   location.y=random(-300,300);
     px=random(100,400);
   py=random(100,400);
   
  }
 
 
  }
   
  
  void display(){     //qq desenho do robo
   pushMatrix();
  translate(xc,yc);
   rotate(ang+radians(90));
    strokeWeight(1);
fill(255,255,255);
stroke(255,0,0);
rect((xc-width/2)-15,(yc-height/2)-15,30,30); //corpo
fill(0,0,0);
rect((xc-width/2)-20,(yc-height/2)-7.5,5,15);//rodas
rect((xc-width/2)+15,(yc-height/2)-7.5,5,15);
//println(velocity.x,velocity.y);
//-------------------------------------MARCAÇÕES DO ROBO---------------------------------------
stroke(200,0,0);
fill(255,0,0);//marcação frente vermeho
triangle(xc-width/2+5,l.yc-height/2+15,xc-width/2-5,yc-height/2+15,xc-width/2,l.yc-height/2+10);
stroke(0,255,0);
fill(0,255,0);//marcação tras verde
triangle(xc-width/2+5,yc-height/2-14,xc-width/2-5,l.yc-height/2-14,xc-width/2,yc-height/2-9);
stroke(0,0,255);
fill(0,0,255);//marcação esquerda azul
triangle(xc-width/2-15,yc-height/2+5,xc-width/2-15,yc-height/2-5,xc-width/2-10,yc-height/2);
stroke(255,175,0);
fill(255,255,0);//marcação direita amarelo
triangle(xc-width/2+15,yc-height/2+5,xc-width/2+15,yc-height/2-5,xc-width/2+10,yc-height/2);
//---------------------------------------------------------------------------------------------
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
arc((xc),(yc)+15,100,100,0.33*PI,0.67*PI);//baixo

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
arc((xc),(ye)-15,100,100,1.33*PI,1.67*PI);//cima

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
arc((xc)+15,(yc),100,100,1.833*PI,2.167*PI);//direito

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
arc((xc)-15,(yc),100,100,0.83*PI,1.167*PI);//esquerdo
*/
popMatrix();
  }
   void mapa(){
   x1=y1=15;

   stroke(0);
   noFill();
  strokeWeight(15);
     
  rect(l.location.x-px,l.location.y-py,1000+0.2*width,1000+0.2*height);
 }
}

//----------------------------------------------------------------------------
//objetos na cena 
class objeto extends Lagann{
   
  PVector location;
 int g1,g2,ux,uy;
    float c1,c2;

  objeto(int tg1,int tg2,int tux,int tuy){
     location = new PVector(random(-300,300),random(-300,300)); // Onde a escada 
      g1=tg1;
      g2=tg2;
      ux=tux;
      uy=tuy;
      
  }

  void obst(){
   strokeWeight(0);
   fill(0);
c1=(l.location.x -px)+30*g1;
c2=(l.location.y -py)+30*g2;
//location = new PVector(c1,c2);
rect(c1,c2,30*ux,30*uy); 
//println(c1,c2);

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
    fill(128+127*sin(angle),128+127*sin(angle),128+127*sin(angle),13);
    rect(x,y,w,h); 
  }
}
//----------------------------------------------------
//                     COMEÇO
//----------------------------------------------------
void setup() {
  size(900, 900);
  a = width;
  b = height;
  m=random(1,10);
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
  o[0].obst();
  o[1].obst();
}