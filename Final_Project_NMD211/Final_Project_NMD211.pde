//Elijah Story
//11-14-2020
//Final project for NMD211

//Inspiration for key input from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously

/*
This is a game that can be played with the WASD keys or can be played with the Arduino/accelerometer. 
Instructions to building the Arduino controller can be found in the GitHub repository. 
The game reads and loads 6 levels from a text file in the data folder. After each level is won, the level file is updated. 
The game will load in full screen mode and will adjust all the variables accordingly. 
This means that it should look and play the same no matter what size screen it is played. 
#One potential flaw is that the penguin seems to move at different speeds when I play it on my desktop(Windows),
and when I play it on my laptop(Mac). The screens are different sizes. The game looks good on both, it's just the speed that seems to change.#

The goal of the game is to reach the fish as fast as possible without sliding off the iceberg or into a hole. 
Each level is locked(other than the first one) and will only be unlocked once the previous level is won. 
Each unlocked level can be replayed multiple times to try and better the score.
*/

import processing.serial.*;                          //import the Serial library

float[][] keys = {{0, 0}, {0, 0}, {0, 0}, {0, 0}};   //index order [X][]=(0=w, 1=a, 2=s, 3=d), [][X]=(speed for that direction)
float speedMax;                                      //max speed the peguin can move in any direction
x_yControler player;                                 //player object
float slideX;                                        //holds the speed that the player's x will slide
float slideY;                                        //holds the speed that the player's y will slide
boolean cursorActive = false;                        //this is not used yet. it changes how the peguin moves if the Arduino need a cursor
PImage penguin;                                      //holds the image for the peguin
PImage iceChunk;                                     //holds the image for the iceburg
PImage hole;                                         //holds the image for the hole in the ice
PImage fish;                                         //holds the image for the fish
float dir;                                           //used to rotate the peguin image based on movement
float x = 0;                                         //used to calculate the dir
float y = 0;                                         //used to calculate the dir
boolean playerDead = true;                           //is the player dead
float playerAlpha = 255;                             //used in the death animation
String[] levelFile;                                  //holds all the raw info from level text file
SlideMenu levelMenu;                                 //menu object for the menu that holds the levels
boolean gameInPlay = false;                          //is the player actively in a level
MainMenu mainMenu;                                   //menu object for the main menu you see at the beginning
float[][] holes;                                     //used to hold all the holes in loadded level
boolean levelLoaded = false;                         //is the level done loading
SlideMenu playAgainMenu;                             //menu object for the menu you see if you die
level lastLevel;                                     //holds the level object that was last loaded
Timer timer;                                         //timer object
float[] fishCords = {-100, -100};                    //will hold the cords for the fish
boolean fileWritten = false;                         //has the file been written
Serial myPort;                                       //make the variable that will hold Serial instance
//int[][] tempMOUSE = new int[100][2];                 //this was only used to help design the levels
//int tempIndex = 0;                                   //this was only used to help design the levels


void setup() {
  //size(1080, 608);      //used for testing
  //size(1920, 1080);     //used for testing
  fullScreen();

  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  
  
  /*
  if the Arduino will be used, uncomment either one of myPort assignments based on OS. 
  Also uncomment the budderUntill line. You may need to change the location the Arduino is located. 
  You can uncomment the printArray line to help find where the port is.
  */
  
  //printArray(Serial.list());                                 //Used to find what usb Arduino is in
  //myPort = new Serial(this,"COM5",9600);                     //makes the Serial instance    #### windows
  //myPort = new Serial(this,"/dev/cu.usbmodem142101",9600);   //makes the Serial instance    #### mac
  //myPort.bufferUntil('\n');                                  //tells the serial when to say it has all the info


  levelMenu = new SlideMenu(fixX(329), fixY(83), fixX(1270), fixY(900), false, fixY(18));                                                  //makes the level menu
  playAgainMenu = new SlideMenu(fixX(753), fixY(387), fixX(400), fixY(300), false, fixY(22));                                              //makes the play again menu
  playAgainMenu.addItem(new Button(fixX(781), playAgainMenu.getY()+fixY(40), fixX(340), fixY(100), true, "Retry Level", fixX(30), null));  //adds the retry button to the menu
  playAgainMenu.addItem(new Button(fixX(781), playAgainMenu.getY()+fixY(160), fixX(340), fixY(100), true, "Level Menu", fixX(30), null));  //adds the level menu button to menu

  //string that will be displayed on the mainMenu
  String msg = "This is a template for a message\nI will have at the start of the game\nexplaining how to play.\n\nUse 'w' 'a' 's' 'd' to move the pengiun.\nAvoid the edge of the ice burg and the holes.\nGet to the fish as fast as posible!";
  Button tempB = new Button(fixX(820), fixY(850), fixX(300), fixY(100), true, "Begin Game!", fixX(30), null);  //makes the start button for main menu
  mainMenu = new MainMenu(fixX(329), fixY(83), fixX(1270), fixY(900), true, fixY(18), msg, tempB, fixX(30));   //makes the main menu

  timer = new Timer(fixX(1750), fixY(96), fixX(50));            //makes the timer
  
  levelFile = loadStrings("data/levels.txt");                   //loads the level file
  //levelFile = loadStrings("data/levels copy - Copy.txt");     //was used for quick testing
  
  
  //This chunck reads in the file and makes level objects based on the info gathered
  int index = 1;
  for (int i = 0; i < Integer.parseInt(levelFile[0]); i++) {
    String LN = levelFile[index++];
    int levelIndex = Integer.parseInt(levelFile[index++]);
    boolean UL;
    if (levelFile[index++].equals("t")) {
      UL = true;
    } else {
      UL = false;
    }
    String CT = levelFile[index++];
    float SX = Float.parseFloat(levelFile[index++]);
    float SY = Float.parseFloat(levelFile[index++]);
    float EX = Float.parseFloat(levelFile[index++]);
    float EY = Float.parseFloat(levelFile[index++]);
    int AH = Integer.parseInt(levelFile[index++]);
    float[][] tempH = new float[AH][2];
    for (int x = 0; x < tempH.length; x++) {
      tempH[x][0] = Float.parseFloat(levelFile[index++]);
      tempH[x][1] = Float.parseFloat(levelFile[index++]);
    }
    float tempX;
    float tempY;
    if (i <= 2) {
      tempX = fixX(440 + 380*i);
      tempY = levelMenu.getY()+fixY(120);
    } else {
      tempX = fixX(440 + 380*(i%3));
      tempY = levelMenu.getY()+fixY(520);
    }
    level temp = new level(LN, UL, CT, AH, tempH, SX, SY, EX, EY, levelIndex);
    levelMenu.addItem(new Button(tempX, tempY, fixX(285), fixY(300), UL, LN+"\n"+CT, fixX(50), temp));
  }



  slideX = fixX(0.02);
  slideY = fixY(0.02);
  speedMax = fixX(3);

  penguin = loadImage("penguin-V2.png");
  penguin.resize(0, (int)fixY(30));
  iceChunk = loadImage("ice-chunk.png");
  iceChunk.resize((int)fixX(1200), 0);
  hole = loadImage("hole.png");
  hole.resize((int)fixX(860), 0);
  fish = loadImage("fish.png");
  fish.resize((int)fixX(64), 0);

  player = new x_yControler(width/2, height/2, "player");
}

void draw() {
  background(184, 227, 227);

  image(iceChunk, width/2, height/2);
  if (levelLoaded) {
    drawLevel();
    if (levelMenu.isAway() && !gameInPlay && playAgainMenu.isAway() && !playerDead) {
      gameInPlay = true;
      timer.startTime();
    }
  }

  float playerX = player.getX();
  float playerY = player.getY();

  image(fish, fishCords[0], fishCords[1]);

  push();
  translate(playerX, playerY);
  dir = atan2((playerX-x)-playerX, (playerY-y)-playerY);
  rotate(-dir);
  tint(255, playerAlpha);
  image(penguin, 0, 0);
  pop();

  inputUpdate();

  if (playerX < fixX(370) || playerX > fixX(1555) ||
    playerY < fixY(120) || playerY > fixY(970)) {
    playerDead = true;
    timer.stopTime();
    deathSceen();
  }
  
  if (!playerDead) {
    player.addY(-keys[0][1]);
    player.addX(-keys[1][1]);
    player.addY(keys[2][1]);
    player.addX(keys[3][1]);

    x = -keys[1][1] + keys[3][1];
    y = -keys[0][1] + keys[2][1];
  }
  
  timer.display();
  levelMenu.display();
  mainMenu.display();
  playAgainMenu.display();
  
  //this was only used to help design the levels
  //for(int i = 0; i < tempIndex; i++){
  //   fill(255,0,0);
  //   ellipse(tempMOUSE[i][0],tempMOUSE[i][1],40,40);
  //}
}

float fixX(float x) {
  return map(x, 0, 1920, 0, width);
}

float fixY(float y) {
  return map(y, 0, 1080, 0, height);
}

//void inputUpdate() {
//  for (int i = 0; i < keys.length; i++) {
//    if (keys[i][0] == 1 && keys[i][1] < speedMax) {
//      if (i % 2 == 0) {
//        keys[i][1] += slideY;
//      } else {
//        keys[i][1] += slideX;
//      }
//    } else if (keys[i][1] > 0) {
//        if (i % 2 == 0) {
//          keys[i][1] -= slideY;
//        } else {
//          keys[i][1] -= slideX;
//        }
//    } else if (keys[i][1] < 0) {
//      keys[i][1] = 0;
//    }
//  }
//}

void inputUpdate() {
  for (int i = 0; i < keys.length; i++) {
    if (keys[i][0] == 1 && keys[i][1] < speedMax) {
      if (!cursorActive) {
        if (i % 2 == 0) {
          keys[i][1] += slideY;
        } else {
          keys[i][1] += slideX;
        }
      } else {
        if (i % 2 == 0) {
          keys[i][1] = fixY(speedMax*3);
        } else {
          keys[i][1] = fixX(speedMax*3);
        }
      }
    } else if (keys[i][1] > 0) {
      if (!cursorActive) {
        if (i % 2 == 0) {
          keys[i][1] -= slideY;
        } else {
          keys[i][1] -= slideX;
        }
      } else {
        keys[i][1] = 0;
      }
    } else if (keys[i][1] < 0) {
      keys[i][1] = 0;
    }
  }
}

void deathSceen() {
  if (playerDead && playerAlpha > 0) {
    gameInPlay = false;
    playerAlpha -= 2;
  } else if (!playAgainMenu.getDown()) {
    playAgainMenu.setDown(true);
    player.setX(fixX(lastLevel.getStartX()));
    player.setY(fixY(lastLevel.getStartY()));
  }
}

void loadLevel(level loadedLevel) {
  player.setX(fixX(loadedLevel.getStartX()));
  player.setY(fixY(loadedLevel.getStartY()));
  fishCords[0] = fixX(loadedLevel.getEndX());
  fishCords[1] = fixY(loadedLevel.getEndY());
  holes = loadedLevel.getHoles();
  playerDead = false;
  fileWritten = false;
  playerAlpha = 255;
  keys[0][1] = 0;
  keys[1][1] = 0;
  keys[2][1] = 0;
  keys[3][1] = 0;

  lastLevel = loadedLevel;
  levelLoaded = true;
}

void drawLevel() {
  float x = player.getX();
  float y = player.getY();

  if (dist(x, y, fishCords[0], fishCords[1]) <= 10 && !fileWritten) {
    levelWin();
  }

  for (int i = 0; i < holes.length; i++) {
    image(hole, round(fixX(holes[i][0])), round(fixY(holes[i][1])));
    if (dist(x, y, round(fixX(holes[i][0])), round(fixY(holes[i][1]))) <= fixX(25)) {
      playerDead = true;
      timer.stopTime();
      deathSceen();
    }
  }
}

void levelWin() {
  timer.stopTime();
  gameInPlay = false;
  playerDead = true;
  upDateLevel();
  levelMenu.setDown(true);
  writeToFile();
  fileWritten = true;
}

void upDateLevel() {
  String temp = timer.compare(lastLevel.getTime());
  Button[] buttons = levelMenu.getButton();
  level templevel = buttons[lastLevel.getLevelIndex()].getLevel();
  templevel.setTime(temp);
  buttons[lastLevel.getLevelIndex()].setLabel(templevel.getLName()+"\n"+templevel.getTime());
  if (!lastLevel.getLName().equals("Level 6")) {
    level lTemp = buttons[lastLevel.getLevelIndex()+1].getLevel();
    lTemp.setUnlocked(true);
    buttons[lastLevel.getLevelIndex()+1].setUnlocked(true);
  }
}

void writeToFile() {
  PrintWriter output = createWriter("data/levels.txt");
  Button[] button = levelMenu.getButton();
  output.println(button.length);
  for (int i = 0; i < button.length; i++) {
    level cur = button[i].getLevel();
    output.println(cur.getLName());
    output.println(cur.getLevelIndex());
    if(cur.getUnlocked()){
      output.println("t");
    }else{
      output.println("f"); 
    }
    output.println(cur.getTime());
    output.println(cur.getStartX());
    output.println(cur.getStartY());
    output.println(cur.getEndX());
    output.println(cur.getEndY());
    output.println(cur.getHoleAmount());
    float[][] holes = cur.getHoles();
    for(int x = 0; x < holes.length; x++){
      output.println(holes[x][0]);
      output.println(holes[x][1]);
    }
  }
  output.flush();
  output.close();
}

String[] enlarge(String[] old) {
  String[] newArray = new String[old.length*2];
  for (int i = 0; i < old.length; i++) {
    newArray[i] = old[i];
  }
  return newArray;
}

void keyPressed() {
  if (gameInPlay) {
    if (key == 'w') {
      keys[0][0] = 1;
    }  
    if (key == 'a') {
      keys[1][0] = 1;
    }
    if (key == 's') {
      keys[2][0] = 1;
    }
    if (key == 'd') {
      keys[3][0] = 1;
    }
  }
}

void keyReleased() {
  if (key == 'w') {
    keys[0][0] = 0;
  }  
  if (key == 'a') {
    keys[1][0] = 0;
  }
  if (key == 's') {
    keys[2][0] = 0;
  }
  if (key == 'd') {
    keys[3][0] = 0;
  }
}

void mousePressed() {
  //println("\n\nNEW ENTRY==========="+(tempIndex-1));
  //tempMOUSE[tempIndex][0] = mouseX;
  //tempMOUSE[tempIndex][1] = mouseY;
  //tempIndex++;
  //for(int i = 0; i < tempIndex; i++){
  //  println(tempMOUSE[i][0]+"\n"+tempMOUSE[i][1]);
  //}
  
  
  if (mainMenu.getButton().buttonClicked()) {
    levelMenu.setDown(true);
    mainMenu.setDown(false);
  }

  if (levelMenu.getDown()) {
    Button[] temp = levelMenu.getButton();
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].buttonClicked()) {
        levelMenu.setDown(false);
        loadLevel(temp[i].getLevel());
      }
    }
  } else {
    Button[] temp = playAgainMenu.getButton();
    if (temp[0].buttonClicked()) {
      loadLevel(lastLevel);
      timer.setTime("00:00:00");
      playAgainMenu.setDown(false);
    }
    if (temp[1].buttonClicked()) {
      playAgainMenu.setDown(false);
      levelMenu.setDown(true);
    }
  }
}

void serialX(String oldX){
  float x = Float.parseFloat(oldX);
  print("X = "+x+"   ");
  if(x > 0.2 || x < -0.2){
    if(x > 0){
      x = abs(x);
      if(keys[3][1] < x){
        keys[3][1] = x;
      }
    }else{
      x = abs(x);
      if(keys[1][1] < x){
        keys[1][1] = x;
      }
    }
  }
}

void serialY(String oldY){
  float y = Float.parseFloat(oldY);
  println("Y = "+y);
  if(y > 0.2 || y < -0.2){
    if(y < 0){
      y = abs(y);
      if(keys[2][1] < y){
        keys[2][1] = y;
      }
    }else{
      y = abs(y);
      if(keys[0][1] < y){
        keys[0][1] = y;
      }
    }
  }
}

void serialEvent(Serial myPort){           //handles the Serial port event
  String input = myPort.readString();
  if(input != null && input .length() > 7){
    int tabLocation = input.indexOf('\t');
    serialX(input.substring(0,tabLocation));
    serialY(input.substring(tabLocation));
  }
  
  myPort.write(0);                         //tells the ardunio that it is ready for new input
}
