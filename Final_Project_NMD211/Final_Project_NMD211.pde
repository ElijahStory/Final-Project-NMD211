//Elijah Story
//11-14-2020
//Final project for NMD211

//Inspiration from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously


float[][] keys = {{0,0},{0,0},{0,0},{0,0}};  //index order 0=w, 1=a, 2=s, 3=d
float speedMax;           //speed the dot moves
x_yControler player;
float slideX;
float slideY;
boolean cursorActive = false;
PImage penguin;
PImage iceChunk;
PImage hole;
float dir;
float x = 0;
float y = 0;
boolean playerDead = false;
float playerAlpha = 255;
String[] levelFile;
linkedList<level> levels = new linkedList<level>();

void setup(){
  //size(1080,608);
  size(1920,1080);
  //fullScreen();
  
  levelFile = loadStrings("levels.txt");
  int index = 1;
  for(int i = 0; i < Integer.parseInt(levelFile[0]); i++){
    String LN = levelFile[index++];
    boolean UL;
    if(levelFile[index++].equals("t")){
      UL = true;
    }else{
      UL = false;
    }
    String CT = levelFile[index++];
    int AH = Integer.parseInt(levelFile[index++]);
    float[][] tempH = new float[AH][2];
    for(int x = 0; x < tempH.length; x+=2){
       tempH[x][0] = fixX(Integer.parseInt(levelFile[index++]));
       tempH[x][1] = fixX(Integer.parseInt(levelFile[index++]));
    }
    levels.add(new level(LN,UL,CT,AH,tempH));
  }
  //node<level> temp = levels.getHead();
  
  
  
  slideX = fixX(0.02);
  slideY = fixY(0.02);
  speedMax = 3;
  
  penguin = loadImage("penguin-V2.png");
  penguin.resize(0,(int)fixY(30));
  iceChunk = loadImage("ice-chunk.png");
  iceChunk.resize((int)fixX(1200),0);
  hole = loadImage("hole.png");
  hole.resize((int)fixX(860),0);

  
  player = new x_yControler(width/2,height/2,"player");
  
}

void draw(){
  background(184, 227, 227);
  imageMode(CENTER);
  rectMode(CENTER);
  
  image(iceChunk, width/2, height/2);
  
  push();
  translate(player.getX(), player.getY());
  dir = atan2((player.getX()-x)-player.getX(),(player.getY()-y)-player.getY());
  rotate(-dir);
  tint(255,playerAlpha);
  image(penguin, 0, 0);
  pop();
  
  inputUpdate();
  
  if(player.getX() < fixX(370) || player.getX() > fixX(1555) ||
     player.getY() < fixY(120) || player.getY() > fixY(970)){
       playerDead = true;
       deathSceen();
     }
}

float fixX(float x){
  return map(x, 0, 1920, 0, width); 
}

float fixY(float y){
  return map(y, 0, 1080, 0, height); 
}

void inputUpdate(){
  for(int i = 0; i < keys.length; i++){
    if(keys[i][0] == 1 && keys[i][1] < speedMax){
      if(!cursorActive){
        if(i % 2 == 0){
          keys[i][1] += slideY;
        }else{
          keys[i][1] += slideX;
        }
      }else{
        if(i % 2 == 0){
          keys[i][1] = fixY(speedMax*3);
        }else{
          keys[i][1] = fixX(speedMax*3);
        }
      }
    }else if(keys[i][1] > 0){
      if(!cursorActive){
        if(i % 2 == 0){
          keys[i][1] -= slideY;
        }else{
          keys[i][1] -= slideX;
        }
      }else{
        keys[i][1] = 0;
      }
    }else if(keys[i][1] < 0){
      keys[i][1] = 0;
    }
  }
  
  if(!playerDead){
    player.addY(-keys[0][1]);
    player.addX(-keys[1][1]);
    player.addY(keys[2][1]);
    player.addX(keys[3][1]);
    
    x = -keys[1][1] + keys[3][1];
    y = -keys[0][1] + keys[2][1];
  }  
}

void deathSceen(){
  if(playerDead && playerAlpha > 0){
    playerAlpha -= 2;
  }else{
    player.setX(width/2);
    player.setY(height/2);
    playerDead = false;
    playerAlpha = 255;
    keys[0][1] = 0;
    keys[1][1] = 0;
    keys[2][1] = 0;
    keys[3][1] = 0;
  }
}

void keyPressed(){
   if(key == 'w'){keys[0][0] = 1;}  
   if(key == 'a'){keys[1][0] = 1;}
   if(key == 's'){keys[2][0] = 1;}
   if(key == 'd'){keys[3][0] = 1;}
}

void keyReleased(){
   if(key == 'w'){keys[0][0] = 0;}  
   if(key == 'a'){keys[1][0] = 0;}
   if(key == 's'){keys[2][0] = 0;}
   if(key == 'd'){keys[3][0] = 0;}
}

//void mouseClicked(){
//  println(mouseX, mouseY);
//}
