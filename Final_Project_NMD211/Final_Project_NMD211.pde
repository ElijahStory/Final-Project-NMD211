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
float speedMax;                                      //max speed the penguin can move in any direction
x_yControler player;                                 //player object
float slideX;                                        //holds the speed that the player's x will slide
float slideY;                                        //holds the speed that the player's y will slide
boolean cursorActive = false;                        //this is not used yet. it changes how the penguin moves if the Arduino need a cursor
PImage penguin;                                      //holds the image for the penguin
PImage iceChunk;                                     //holds the image for the iceburg
PImage hole;                                         //holds the image for the hole in the ice
PImage fish;                                         //holds the image for the fish
float dir;                                           //used to rotate the penguin image based on movement
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
  String msg = "Help waddles the penguin get across the iceburg to reach\nthe fish as fast as possible. Be careful though! The ice is slippery."+
               "\nDo not slide off the iceberg or into one of the holes.\n\nUse the WASD keys to move.\nIf you are using the Arduino, "+
               "tilt the board in the direction you wish to move.";
               
  Button tempB = new Button(fixX(820), fixY(850), fixX(300), fixY(100), true, "Begin Game!", fixX(30), null);  //makes the start button for main menu
  mainMenu = new MainMenu(fixX(329), fixY(83), fixX(1270), fixY(900), true, fixY(18), msg, tempB, fixX(30));   //makes the main menu

  timer = new Timer(fixX(1750), fixY(96), fixX(50));            //makes the timer
  
  levelFile = loadStrings("data/levels.txt");                   //loads the level file
  //levelFile = loadStrings("data/levels copy - Copy.txt");     //was used for quick testing
  
  
  //This chunck reads in the file and makes level objects based on the info gathered
  int index = 1;                                              //Starts at 1 because says how many levels are in the file.
  for (int i = 0; i < Integer.parseInt(levelFile[0]); i++) {  //loop based on how many levels in file
    String LN = levelFile[index++];                           //reads the level name
    int levelIndex = Integer.parseInt(levelFile[index++]);    //reads the index of the level
    boolean UL;                                               //reads of the level is unlocked or not
    if (levelFile[index++].equals("t")) {                     //turns it into a boolean
      UL = true;
    } else {
      UL = false;
    }
    String CT = levelFile[index++];                           //reads the completed time
    float SX = Float.parseFloat(levelFile[index++]);          //reads the start X cord for the penguin
    float SY = Float.parseFloat(levelFile[index++]);          //reads the start Y cord for the penguin
    float EX = Float.parseFloat(levelFile[index++]);          //reads the end X cord for the fish
    float EY = Float.parseFloat(levelFile[index++]);          //reads the end Y cord for the fish
    int AH = Integer.parseInt(levelFile[index++]);            //reads the amount of holes in level
    float[][] tempH = new float[AH][2];                       //makes a array to hold x and y cords for each hole in level
    for (int x = 0; x < tempH.length; x++) {                  //lood for #holes
      tempH[x][0] = Float.parseFloat(levelFile[index++]);     //read hole X cord
      tempH[x][1] = Float.parseFloat(levelFile[index++]);     //read hole Y cord
    }
    float tempX;                                              //just used to decide where the level button will go
    float tempY;                                              //just used to decide where the level button will go
    if (i <= 2) {                                             //top row of buttons
      tempX = fixX(440 + 380*i);
      tempY = levelMenu.getY()+fixY(120);
    } else {                                                  //bottom row of buttons
      tempX = fixX(440 + 380*(i%3));
      tempY = levelMenu.getY()+fixY(520);
    }
    level temp = new level(LN, UL, CT, AH, tempH, SX, SY, EX, EY, levelIndex);                          //makes the level object with all info
    levelMenu.addItem(new Button(tempX, tempY, fixX(285), fixY(300), UL, LN+"\n"+CT, fixX(50), temp));  //adds level button to the level menu
  }

  //sets the slides and the max speed based on screen size.
  slideX = fixX(0.02);
  slideY = fixY(0.02);
  speedMax = fixX(3);
  
  //loads and resizes each image used
  penguin = loadImage("penguin.png");
  penguin.resize(0, (int)fixY(30));
  iceChunk = loadImage("ice-chunk.png");
  iceChunk.resize((int)fixX(1200), 0);
  hole = loadImage("hole.png");
  hole.resize((int)fixX(860), 0);
  fish = loadImage("fish.png");
  fish.resize((int)fixX(64), 0);

  //makes the player object
  player = new x_yControler(width/2, height/2, "player");
}

void draw() {
  background(184, 227, 227);

  image(iceChunk, width/2, height/2);        //draws the iceburg
  if (levelLoaded) {                         //only draws the level if one is loaded
    drawLevel();
    if (levelMenu.isAway() && !gameInPlay && playAgainMenu.isAway() && !playerDead) {  //starts the game if all the menus are out of the way
      gameInPlay = true;                     //the player is in a level
      timer.startTime();                     //start the timer
    }
  }

  float playerX = player.getX();             //get the player X cord
  float playerY = player.getY();             //get the player Y cord

  image(fish, fishCords[0], fishCords[1]);   //draw the fish at its location

  //this chunck draws the penguin
  push();
  translate(playerX, playerY);
  dir = atan2((playerX-x)-playerX, (playerY-y)-playerY);  //calculates the direction the penguin should face
  rotate(-dir);                                           //rotates the penguin
  tint(255, playerAlpha);                                 //used in the death animation
  image(penguin, 0, 0);                                   //draws the penguin
  pop();

  inputUpdate();                                          //updates part of the key input
  
  //checks if the player is off the iceburg
  if (playerX < fixX(370) || playerX > fixX(1555) || playerY < fixY(120) || playerY > fixY(970)) {
    playerDead = true;    //say the player has died
    timer.stopTime();     //stop the timer
    deathSceen();         //play the death animation
  }
  
  if (!playerDead) {            //if the player is alive, update its location base on key input and slide time
    player.addY(-keys[0][1]);
    player.addX(-keys[1][1]);
    player.addY(keys[2][1]);
    player.addX(keys[3][1]);

    x = -keys[1][1] + keys[3][1];  //used to calculate the dir
    y = -keys[0][1] + keys[2][1];  //used to calculate the dir
  }
  
  //display all the menus and timer
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

//used to fix the X cord based on current screen size.
//maps the X based on the size of screen used to make the game and the current size
float fixX(float x) {
  return map(x, 0, 1920, 0, width);
}

//used to fix the Y cord based on current screen size.
//maps the Y based on the size of screen used to make the game and the current size
float fixY(float y) {
  return map(y, 0, 1080, 0, height);
}

//takes the info from which keys is pressed and updates that directions slide
void inputUpdate() {
  for (int i = 0; i < keys.length; i++) {            //loop for each of the 4 keys
    if (keys[i][0] == 1 && keys[i][1] < speedMax) {  //check if the key is active([][0] == 1), and the speed for that key is not maxed([][1] < ~3)
      if (!cursorActive) {                           //if in slide mode
        if (i % 2 == 0) {                            //if key in loop is even ("W" or "S")
          keys[i][1] += slideY;                      //add slide to the Y key from loop
        } else {                                     //if key in loop is odd ("A" or "D")
          keys[i][1] += slideX;                      //add slide to the X key from loop
        }
      } else {                                       //not in slide mode
        if (i % 2 == 0) {                            //if key in loop is even ("W" or "S")
          keys[i][1] = fixY(speedMax*3);             //set movement for Y
        } else {                                     //if key in loop is odd ("A" or "D")
          keys[i][1] = fixX(speedMax*3);             //set movement for X
        }
      }
    } else if (keys[i][1] > 0 && keys[i][0] == 0) {  //check if the key is not active([][0] == 0), and the speed for that key is not 0([][1] > 0)
      if (!cursorActive) {                           //if in slide mode
        if (i % 2 == 0) {                            //if key in loop is even ("W" or "S")
          keys[i][1] -= slideY;                      //remove slide to the Y key from loop
        } else {                                     //if key in loop is odd ("A" or "D")
          keys[i][1] -= slideX;                      //remove slide to the X key from loop
        }
      } else {                                       //not in slide mode
        keys[i][1] = 0;                              //just set it to 0(no movement or slide)
      }
    } else if (keys[i][1] < 0) {                     //make sure the keys speed never is less than 0
      keys[i][1] = 0;
    }
  }
}

//play the death animation and manage play again menu
void deathSceen() {
  if (playerDead && playerAlpha > 0) {        //loops until the penguin is fully transparent
    gameInPlay = false;                       //say the player is not in a game
    playerAlpha -= 2;                         //make the player more transparent
  } else if (!playAgainMenu.getDown()) {      //if the menu is up
    playAgainMenu.setDown(true);              //pull the menu down
    player.setX(fixX(lastLevel.getStartX())); //reset the player X
    player.setY(fixY(lastLevel.getStartY())); //reset the player Y
  }
}

//reads the level info from level object
void loadLevel(level loadedLevel) {
  player.setX(fixX(loadedLevel.getStartX()));    //gets the player X and sets it
  player.setY(fixY(loadedLevel.getStartY()));    //gets the player Y and sets it
  fishCords[0] = fixX(loadedLevel.getEndX());    //gets the fish X
  fishCords[1] = fixY(loadedLevel.getEndY());    //gets the fish Y
  holes = loadedLevel.getHoles();                //gets the holes in level
  playerDead = false;                            //say the player is not dead
  fileWritten = false;                           //say the file is not written
  playerAlpha = 255;                             //makes the player solid
  keys[0][1] = 0;
  keys[1][1] = 0;                                //makes sure the player is standing still at start(no old slide info)
  keys[2][1] = 0;
  keys[3][1] = 0;

  lastLevel = loadedLevel;                       //updates the last loaded level
  levelLoaded = true;                            //say the level is done loading
}

//draws all the obstacles of loaded level
void drawLevel() {
  //gets the players X and Y
  float x = player.getX();
  float y = player.getY();
  
  //checks if the player is close enough to the fish to win
  if (dist(x, y, fishCords[0], fishCords[1]) <= 10 && !fileWritten) {
    levelWin();
  }

  //loops for each hole in level to check if the player is close enough to "fall in" and die. also draws the holes
  for (int i = 0; i < holes.length; i++) {
    image(hole, round(fixX(holes[i][0])), round(fixY(holes[i][1])));        //draw hole
    if (dist(x, y, round(fixX(holes[i][0])), round(fixY(holes[i][1]))) <= fixX(25)) {
      playerDead = true;     //say the player has died
      timer.stopTime();      //stop the timer
      deathSceen();          //play the death animation
    }
  }
}

//if the player reached the fish
void levelWin() {
  timer.stopTime();        //stop the timer
  gameInPlay = false;      //say the player is not in level
  playerDead = true;
  upDateLevel();           //update the current level
  levelMenu.setDown(true); //pull down the level menu
  writeToFile();           //update the text file
  fileWritten = true;      //say that the file is written
}

//updates the completion time and unlock level if necessary
void upDateLevel() {
  String temp = timer.compare(lastLevel.getTime());      //gets the faster time
  Button[] buttons = levelMenu.getButton();              //temporarily pulls all level buttons
  level templevel = buttons[lastLevel.getLevelIndex()].getLevel();  //gets the level button just played
  templevel.setTime(temp);                               //updates time in the level object
  buttons[lastLevel.getLevelIndex()].setLabel(templevel.getLName()+"\n"+templevel.getTime());  //updates the time on level button
  if (!lastLevel.getLName().equals("Level 6")) {
    level lTemp = buttons[lastLevel.getLevelIndex()+1].getLevel();  //gets the next level
    lTemp.setUnlocked(true);                                        //sets the level object unlock state to true
    buttons[lastLevel.getLevelIndex()+1].setUnlocked(true);         //sets the level button unlock state to true
  }
}

//writes all the level info to the text file
void writeToFile() {
  PrintWriter output = createWriter("data/levels.txt");  //makes a file writer
  Button[] button = levelMenu.getButton();               //get all the levels
  output.println(button.length);                         //writes how many levels
  for (int i = 0; i < button.length; i++) {              //loops for each level
    level cur = button[i].getLevel();
    output.println(cur.getLName());                      //write the level name
    output.println(cur.getLevelIndex());                 //write the level index
    if(cur.getUnlocked()){                               //writes if the level is unlocked or not
      output.println("t");
    }else{
      output.println("f"); 
    }
    output.println(cur.getTime());                       //writes the completion time
    output.println(cur.getStartX());                     //writes the player start X
    output.println(cur.getStartY());                     //writes the player start Y
    output.println(cur.getEndX());                       //writes the fish end X
    output.println(cur.getEndY());                       //writes the fish end Y
    output.println(cur.getHoleAmount());                 //writes the amount of holes in level
    float[][] holes = cur.getHoles();                    //gets array of holes in level
    for(int x = 0; x < holes.length; x++){               //loops for each hole in level
      output.println(holes[x][0]);                       //writes current holes X
      output.println(holes[x][1]);                       //writes current holes Y
    }
  }
  output.flush();
  output.close();
}

//makes any array twice as long and moves all info to new array
String[] enlarge(String[] old) {
  String[] newArray = new String[old.length*2];  //make new array
  for (int i = 0; i < old.length; i++) {         //loop for every item of old array
    newArray[i] = old[i];
  }
  return newArray;
}


void keyPressed() {
  if (gameInPlay) {      //only updates if the game is in play
    //updates the array saying that the key is being pressed for each key
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
  //updates the array saying that the key is NOT being pressed for each key
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
  //this chunk was used to help design the levels. It printed out where the mouse was clicked and added cords to draw a dot
  //println("\n\nNEW ENTRY==========="+(tempIndex-1));
  //tempMOUSE[tempIndex][0] = mouseX;
  //tempMOUSE[tempIndex][1] = mouseY;
  //tempIndex++;
  //for(int i = 0; i < tempIndex; i++){
  //  println(tempMOUSE[i][0]+"\n"+tempMOUSE[i][1]);
  //}
  
  //checks if the mouse clicks the start button on the main menu
  if (mainMenu.getButton().buttonClicked()) {
    levelMenu.setDown(true);    //pulls down the level menu
    mainMenu.setDown(false);    //removes the main menu
  }

  if (levelMenu.getDown()) {                 //if the level menu is down
    Button[] temp = levelMenu.getButton();
    for (int i = 0; i < temp.length; i++) {  //loop for all buttons in level menu
      if (temp[i].buttonClicked()) {         //if a button was pressed
        levelMenu.setDown(false);            //pull up the menu
        loadLevel(temp[i].getLevel());       //load the level clicked
      }
    }
  } else {                                   //if the play again menu is down
    Button[] temp = playAgainMenu.getButton();
    if (temp[0].buttonClicked()) {           //if the play again button is pressed
      loadLevel(lastLevel);                  //load the level
      timer.setTime("00:00:00");             //reset the timer
      playAgainMenu.setDown(false);          //pull up the menu
    }
    
    if (temp[1].buttonClicked()) {           //if the level menu is clicked
      playAgainMenu.setDown(false);          //pull up the menu
      levelMenu.setDown(true);               //pull down the level menu
    }
  }
}

//uses the input from the Serial port as a key press for the X values
void serialX(String oldX){
  float x = Float.parseFloat(oldX);  //makes it a float
  //print("X = "+x+"   ");
  if(x > 0.2 || x < -0.2){           //if the data is not noise
    if(x > 0){                       //if the tilt is to the RIGHT
      x = abs(x);
      if(keys[3][1] < x){            //if the current slid is less than tilt
        keys[3][1] = x;              //set slide to the tilt
      }
    }else{                           //if the tilt is to the LEFT
      x = abs(x);
      if(keys[1][1] < x){            //if the current slid is less than tilt
        keys[1][1] = x;              //set slide to the tilt
      }
    }
  }
}

//uses the input from the Serial port as a key press for the Y values
void serialY(String oldY){
  float y = Float.parseFloat(oldY);  //makes it a float
  //println("Y = "+y);
  if(y > 0.2 || y < -0.2){           //if the data is not noise
    if(y < 0){                       //if the tilt is DOWN
      y = abs(y);
      if(keys[2][1] < y){            //if the current slid is less than tilt
        keys[2][1] = y;              //set slide to the tilt
      }
    }else{                           //if the tilt is UP
      y = abs(y);
      if(keys[0][1] < y){            //if the current slid is less than tilt
        keys[0][1] = y;              //set slide to the tilt
      }
    }
  }
}

void serialEvent(Serial myPort){             //handles the Serial port event
  String input = myPort.readString();        //gets data
  if(input != null && input .length() > 7){  //only mess with real data
    int tabLocation = input.indexOf('\t');   //find where the spit for X and Y is
    serialX(input.substring(0,tabLocation)); //use X info
    serialY(input.substring(tabLocation));   //use Y info
  }
  
  myPort.write(0);                         //tells the ardunio that it is ready for new input
}
