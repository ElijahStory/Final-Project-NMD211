//Elijah Story
//11-14-2020
//key press example

//This is an example of how you could get multiple key inputs at the same time. 
//I am hoping to use the same array to accept multiple inputs.

//Inspiration from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously


float[][] keys = {{0,0},{0,0},{0,0},{0,0}};  //index order 0=w, 1=a, 2=s, 3=d
float speedMax;           //speed the dot moves
x_yControler player;
float slideX;
float slideY;
boolean cursorActive = true;

void setup(){
  size(1080,608);
  size(1920,1080);
  
  slideX = fixX(0.02);
  slideY = fixY(0.02);
  speedMax = 2;
  
  player = new x_yControler(width/2,height/2);
  
}

void draw(){
  background(255);
  fill(0);
  ellipse(player.getX(),player.getY(),fixX(10),fixY(10));              //draws the dot
  
  inputUpdate();
  //println(keys[0][1],keys[1][1],keys[2][1],keys[3][1]);
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
  
  player.addY(-keys[0][1]);
  player.addX(-keys[1][1]);
  player.addY(keys[2][1]);
  player.addX(keys[3][1]);
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
