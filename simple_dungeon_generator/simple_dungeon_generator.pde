// most part of the credits goes to http://www.codingcookies.com/2012/08/07/procedurally-generating-dungeons/

 import java.util.Iterator;
 import java.util.List;
 //import ddf.minim.*;
 //import ddf.minim.effects.*;
 
 class Room {
    public int x;
    public int y;
    public int width_r;
    public int height_r;
    public int xc;
    public int yc;
    public Room(int x, int y, int width_r, int height_r) {
        super();
        this.x = x;
        this.y = y;
        this.width_r = width_r;
        this.height_r = height_r;
        this.xc=(2*x+width_r)/2;
        this.yc=(2*y+height_r)/2;;
        stroke(255);
        rect(x,y,width_r,height_r);
    }
    public void place(int[][] tiles) {
        // Fill the room with floor tiles. Offsets are necessary
        // for walls.
        for (int xP = x + 1; xP < x + width_r - 1; xP++)
            for (int yP = y + 1; yP < y + height_r - 1; yP++)
                tiles[xP][yP] = 1;
    }
}

 class MapBuilder {
    private  final int MAX_ROOM_WIDTH = 100;
    private  final int MAX_ROOM_HEIGHT = 100;
    private  final int MIN_ROOM_WIDTH = 70;
    private  final int MIN_ROOM_HEIGHT = 70;
    // The following ratios determine the number of rooms to place 
    // based on the total possible number of rooms.
    private  final float MIN_ROOM_RATIO = 0.3;
    private  final float MAX_ROOM_RATIO = 0.7; 
    
    public  int[][] buildMap(int width_r, int height_r) {
        int[][] tiles = new int[width_r][height_r];
        // clear the map
        for (int x = 0; x < width_r; x++)
            for (int y = 0; y < height_r; y++)
                tiles[x][y] = 0;
        // Build the rooms and tunnels
        List<Room> rooms = placeRooms(tiles);
        placeTunnels(tiles, rooms);
        //point(rooms.get(0).xc,rooms.get(0).yc);
        int a=floor(random(1,rooms.size()-1));
        //point(rooms.get(a).xc,rooms.get(a).yc);
        mapa(rooms);
        return tiles;
    }
    
    private  List<Room> placeRooms(int[][] tiles) {
        int mapWidth = tiles.length, mapHeight = tiles[0].length;
        int roomsAcross = mapWidth  / MAX_ROOM_WIDTH, roomsDown  = mapHeight
                / MAX_ROOM_HEIGHT;
        int maxRooms = roomsAcross * roomsDown;
        // use an array of booleans to represent which rooms have been used
        boolean[] usedRooms = new boolean[maxRooms];
        // generate the number of total rooms based on the ratios
        int totalRooms = floor(random( maxRooms * MIN_ROOM_RATIO,
                                       maxRooms * MAX_ROOM_RATIO));
        // generate the rooms
        ArrayList<Room> rooms = new ArrayList<Room>(totalRooms);
        Room room;
        int roomCell;
        int width_r, height_r, x, y;
        for (int i = 0; i < totalRooms; i++) {
            // keep generating a room cell until we find an unused one
            do {
                roomCell = floor(random(0, maxRooms - 1));
            } while (usedRooms[roomCell]);
            usedRooms[roomCell] = true;
            // generate room width and height
            width_r = floor(random(MIN_ROOM_WIDTH, MAX_ROOM_WIDTH));
            height_r = floor(random(MIN_ROOM_HEIGHT, MAX_ROOM_HEIGHT));
            // generate x and y position based on cell x and y. we also
            // generate a random offset with the remaining space in the cell
            // in order to create less square levels.
            x = (roomCell % roomsAcross) * MAX_ROOM_WIDTH;
            x += floor(random(0, MAX_ROOM_WIDTH - width_r));
            y = (roomCell / roomsAcross) * MAX_ROOM_HEIGHT;
            y += floor(random(0, MAX_ROOM_HEIGHT - height_r));
            room = new Room(x, y, width_r, height_r);
            room.place(tiles);
            rooms.add(room);
        }
        return rooms;
        
    }
    private  void placeTunnels(int[][] tiles, List<Room> rooms) {
        
      int deltaX, deltaY, deltaXSign, deltaYSign,carver,carveLength,currentX, currentY;
      boolean movingInX;
      Room currentRoom, goalRoom,draw_hall_x,draw_hall_y;

    // iterate through each room apart the last, tunnelling
    Iterator<Room> iterator = rooms.iterator();
    currentRoom = iterator.next();
    
    while (iterator.hasNext()) {
        goalRoom = iterator.next();
        // calculate the starting position and distance remaining
        // based on the center of the two rooms
        
        currentX = currentRoom.x + (currentRoom.width_r / 2);
        currentY = currentRoom.y + (currentRoom.height_r / 2);
        deltaX = (goalRoom.x + (goalRoom.width_r / 2)) - currentX;
        deltaY = (goalRoom.y + (goalRoom.height_r / 2)) - currentY;
     
        // determine sign to carve in for both directions
        if (deltaX == 0) deltaXSign = 1;
        else deltaXSign = (deltaX / abs(deltaX)); 
        if (deltaY == 0) deltaYSign = 1;
        else deltaYSign = (deltaY / abs(deltaY));
        
        // iterate until we only have 1 direction left
        while (!(deltaX == 0 && deltaY == 0)) {
            // randomly choose a direction
            movingInX = floor(random(2)) == 1;
            // if we are at 0 of current side, switch direction
            if (movingInX && deltaX == 0) movingInX = false;
            if (!movingInX && deltaY == 0) movingInX = true;
            // carve a random length
            carveLength = floor(random(1, (abs(movingInX ? deltaX : deltaY))));
            for (carver = 0; carver < carveLength; carver++) {
                if (movingInX) currentX += deltaXSign * 1;
                else currentY += deltaYSign * 1;
                tiles[currentX][currentY] = 1;
            }
            // update deltas
            if (movingInX) deltaX -= deltaXSign * carveLength;
            else deltaY -= deltaYSign * carveLength;
            
        }
       int p=3;
       draw_hall_x=new Room(currentRoom.xc + deltaXSign*p,currentRoom.yc +deltaYSign*p,(+goalRoom.xc-currentRoom.xc),12);
       draw_hall_y=new Room(goalRoom.xc - deltaXSign*p,goalRoom.yc -deltaYSign*p,12,(-goalRoom.yc+currentRoom.yc));
        currentRoom = goalRoom;
        
    }
    
}//end PlaceTunnels
void grid(){
  strokeWeight(0);
  background(51);
    for(int i=0;i<20;i++){
     for(int j=0;j<21;j++){
       stroke(60);
       line(0+30*i,0,0+30*i,630);
       line(0,0+30*j,width,0+30*j);
     }
    }
  stroke(220);
  line(0,630,600,630);
}
void mapa(List<Room> rooms){
  
 float n;
 int a=floor(random(1,rooms.size()-1));
 n=20;
 int l=3;
 fill(255);
 stroke(0);
 strokeWeight(1);
 rect(rooms.get(a).xc-(n/2)-1,rooms.get(a).yc-1-n/2,n+l,n+l);
 strokeWeight(0);
 fill(0);
 beginShape();
 vertex(rooms.get(a).xc+l+(n/6)-(n/2),rooms.get(a).yc+l-(n/2));
 vertex(rooms.get(a).xc+n-(n/2),rooms.get(a).yc+l-(n/2));
 vertex(rooms.get(a).xc+n-(n/2),rooms.get(a).yc+n-(n/2));
 vertex(rooms.get(a).xc+2*n/3-(n/2),rooms.get(a).yc+n-(n/2));
 vertex(rooms.get(a).xc+2*n/3-(n/2),rooms.get(a).yc+n/3-(n/2));
 vertex(rooms.get(a).xc+l+n/6-(n/2),rooms.get(a).yc+n/3-(n/2));
 endShape();
  fill(255);
}
}// end class MapBuilder
  MapBuilder c=new MapBuilder();
  //Minim minim;
  //AudioPlayer musica;
  int k;
void setup(){
  size(600,700);
   //minim = new Minim(this);
  //musica = minim.loadFile("p3-Tartarus.mp3", 2048);
 //musica.loop();
  c.grid();
  c.buildMap(600, 600); //tiles
 k=0;
 text("Mapa:",10,650);
 text("Térreo",50,650);
}

void draw(){
  
 delay(2000); 
  c.grid();
  c.buildMap(600, 600); //tiles
  k++;
  text("Mapa:",10,650);
  text(k,50,650);
}
