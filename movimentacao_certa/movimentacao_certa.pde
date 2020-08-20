final float IDEAL_FRAME_RATE=60;

abstract class Lagann{
  
  final float size;
  final int lifespanFrameCount;
  final color squareColor;
  final float rotationVelocity;
  int properFrameCount;
  
  float xPosition,yPosition,rotationAngle,xc,yc;
  
  Lagann(float x,float y,color col,int lifespan,float sz,float rotVel){
    xc=x;
    yc=y;
    squareColor=col;
    xPosition=x-(sz/2);
    yPosition=y-(sz/2);
    size=sz;
    lifespanFrameCount=lifespan;
    rotationVelocity = rotVel * TWO_PI / IDEAL_FRAME_RATE;
  }
  
  void update(){
    rotationAngle += rotationVelocity;
    properFrameCount++; 
  }
 abstract void display();
}

final class cima 
        extends Lagann {
  final float xVelocity, yVelocity;
   cima(float x,float y,color col){
    super(x, y, col,60, 20f, 0);
    final float directionAngle = -PI/2 ;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();
    xc += xVelocity;
    yc += yVelocity;
  }
  void display(){
    pushMatrix();
    translate(xc, yc);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
    rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
   final class baixo 
        extends Lagann {
  final float xVelocity, yVelocity;
   baixo(float x,float y,color col){
    super(x, y, col,60, 20f, 0);
    final float directionAngle = PI/2 ;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();
    xc += xVelocity;
    yc += yVelocity;
  }
  void display(){
    pushMatrix();
    translate(xc, yc);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
     rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
   final class direita 
        extends Lagann {
  final float xVelocity, yVelocity;
   direita(float x,float y,color col){
    super(x, y, col,60, 20f, 0);
    final float directionAngle = 0 ;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();
    xc += xVelocity;
    yc += yVelocity;
  }
  void display(){
    pushMatrix();
    translate(xc, yc);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
    rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
   final class esquerda 
        extends Lagann {
  final float xVelocity, yVelocity;
   esquerda(float x,float y,color col){
    super(x, y, col,60, 20f, 0);
    final float directionAngle = PI ;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();
    xc += xVelocity;
    yc += yVelocity;
  }
  void display(){
    pushMatrix();
    translate(xc, yc);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
     rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
    final class giraresq 
        extends Lagann {
  final float xVelocity, yVelocity;
   giraresq(float x,float y,color col){
    super(x, y, col,60, 20f, -PI/8);
    final float directionAngle = PI ;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();

  }
  void display(){
    pushMatrix();
    translate(xc, yc);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
     rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
       final class girardir 
        extends Lagann {
  final float xVelocity, yVelocity,x_hist,y_hist;
   girardir(float x,float y,color col){
    super(x, y, col,60, 20f, PI/8);
    final float directionAngle = PI ;
    x_hist=x;y_hist=y;
    final float speed =3f*60f/IDEAL_FRAME_RATE;
    xVelocity = speed * cos(directionAngle);
    yVelocity = speed * sin(directionAngle);
  }
    void update() {
    super.update();
   
  }
  void display(){
    pushMatrix();
    translate(x_hist, y_hist);
    rotate(rotationAngle);
    stroke(squareColor);
    noFill();
     rect( -size/2, -size/2, size, size);
    popMatrix();
  }
   }
   
   boolean pause=false;
   void keyPressed() {
  if (key == 'p') {
    if (pause == true) loop();
    else noLoop();
    pause = !pause;
  }
}
   Lagann e;
   int i;
   void setup(){
    size(600,600); 
    i=0;
    e=new cima(30,570,0);
  
   }
   void draw(){
     background(255); 

     e.update();e.display();
      if(e.yc<30) {e=new girardir(30,30,0);i=1;}
      if((e.rotationAngle/(2*PI)>0.25 && i==1 ) ){e=new direita(30,30,0);}
      
      if(e.xc>570){e=new girardir(570,30,0);i=2;}
      if((e.rotationAngle/(2*PI)>0.25 && i==2 )){e=new baixo(570,30,0);}
      
      if(e.yc>570){e=new giraresq(570,570,0);i=3;}
      if((e.rotationAngle/(2*PI)<-0.25 && i==3)){e=new esquerda(570,570,0);}
      
      if(e.xc<30){e=new giraresq(30,570,0);i=4;}
      if((e.rotationAngle/(2*PI)<-0.25 && i==4)){e=new cima(30,570,0);}
     
   println(e.rotationAngle/(2*PI),e.xc,e.yc);
   }