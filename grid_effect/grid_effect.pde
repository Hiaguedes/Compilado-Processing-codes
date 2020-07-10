// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = width/2;
int rows = height/2;

void setup() {
 
  size(600,600);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*30,j*30,30,30,4*i+3*j);
    }
  }
}

void draw() {
  background(240);
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Oscillate and display each object
      grid[i][j].oscillate();
      grid[i][j].display();
    }
  }
}

// A Cell object
class Cell {
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
    // Color calculated using sine wave
    fill(128+127*sin(angle),128+127*sin(angle),128+127*sin(angle),25);
    rect(x,y,w,h); 
  }
}
