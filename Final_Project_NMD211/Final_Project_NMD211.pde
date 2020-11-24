//Elijah Story
//11-14-2020
//Final project for NMD211

//Inspiration for key input from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously


float[][] keys = {{0, 0}, {0, 0}, {0, 0}, {0, 0}};  //index order 0=w, 1=a, 2=s, 3=d
float speedMax;           //speed the dot moves
x_yControler player;
float slideX;
float slideY;
boolean cursorActive = false;
PImage penguin;
PImage iceChunk;
PImage hole;
PImage fish;
float dir;
float x = 0;
float y = 0;
boolean playerDead = true;
float playerAlpha = 255;
String[] levelFile;
SlideMenu levelMenu;
boolean gameInPlay = false;
MainMenu mainMenu;
float[][] holes;
boolean levelLoaded = false;
SlideMenu playAgainMenu;
level lastLevel;
Timer timer;
float[] fishCords = {-100, -100};


void setup() {
  size(1080, 608);
  //size(1920, 1080);
  //fullScreen();

  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  levelMenu = new SlideMenu(fixX(329), fixY(83), fixX(1270), fixY(900), false, fixY(18));
  playAgainMenu = new SlideMenu(fixX(753), fixY(387), fixX(400), fixY(300), false, fixY(22));
  playAgainMenu.addItem(new Button(fixX(781), playAgainMenu.getY()+fixY(40), fixX(340), fixY(100), true, "Retry Level", fixX(30), null));
  playAgainMenu.addItem(new Button(fixX(781), playAgainMenu.getY()+fixY(160), fixX(340), fixY(100), true, "Level Menu", fixX(30), null));

  String msg = "This is a template for a message\nI will have at the start of the game\nexplaining how to play.\n\nUse 'w' 'a' 's' 'd' to move the pengiun.\nAvoid the edge of the ice burg and the holes.\nGet to the fish as fast as posible!";
  Button tempB = new Button(fixX(820), fixY(850), fixX(300), fixY(100), true, "Begin Game!", fixX(30), null);
  mainMenu = new MainMenu(fixX(329), fixY(83), fixX(1270), fixY(900), true, fixY(18), msg, tempB, fixX(30));

  timer = new Timer(fixX(1750), fixY(96), fixX(50));

  levelFile = loadStrings("levels.txt");
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
    float SX = fixX(Integer.parseInt(levelFile[index++]));
    float SY = fixY(Integer.parseInt(levelFile[index++]));
    float EX = fixX(Integer.parseInt(levelFile[index++]));
    float EY = fixY(Integer.parseInt(levelFile[index++]));
    int AH = Integer.parseInt(levelFile[index++]);
    float[][] tempH = new float[AH][2];
    for (int x = 0; x < tempH.length; x++) {
      tempH[x][0] = fixX(Integer.parseInt(levelFile[index++]));
      tempH[x][1] = fixY(Integer.parseInt(levelFile[index++]));
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
  speedMax = 3;

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
  
  image(fish,fishCords[0], fishCords[1]);
  
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
    
}

float fixX(float x) {
  return map(x, 0, 1920, 0, width);
}

float fixY(float y) {
  return map(y, 0, 1080, 0, height);
}

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
    player.setX(lastLevel.getStartX());
    player.setY(lastLevel.getStartY());
  }
}

void loadLevel(level loadedLevel) {
  player.setX(loadedLevel.getStartX());
  player.setY(loadedLevel.getStartY());
  fishCords[0] = loadedLevel.getEndX();
  fishCords[1] = loadedLevel.getEndY();
  holes = loadedLevel.getHoles();
  playerDead = false;
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
  
  if(dist(x,y,fishCords[0],fishCords[1]) <= 10){
     levelWin();
  }
  
  for (int i = 0; i < holes.length; i++) {
    image(hole, holes[i][0], holes[i][1]);
    if (dist(x, y, holes[i][0], holes[i][1]) <= fixX(25)) {
      playerDead = true;
      timer.stopTime();
      deathSceen();
    }
  }
}

void levelWin(){
  timer.stopTime();
  gameInPlay = false;
  playerDead = true;
  upDateLevel();
}

void upDateLevel(){
  String temp = timer.compare(timer.getTime());
  lastLevel.setTime(temp);
  if(!lastLevel.getLName().equals("Level 6")){
    Button[] buttons = levelMenu.getButton();
    buttons[lastLevel.getLevelIndex()+1].setUnlocked(true);
  }
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
  println(mouseX, mouseY);
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
