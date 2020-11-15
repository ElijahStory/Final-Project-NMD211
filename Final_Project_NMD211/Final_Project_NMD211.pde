//Elijah Story
//11-14-2020
//key press example

//This is an example of how you could get multiple key inputs at the same time. 
//I am hoping to use the same array to accept multiple inputs.

//Inspiration from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously


float[][] keys = {{0,0},{0,0},{0,0},{0,0}};  //index order 0=w, 1=a, 2=s, 3=d
float speedMax = 2;           //speed the dot moves
x_yControler player;
float slide = 0.02;
boolean cursorActive = true;

void setup(){
  size(800,800);
  
  player = new x_yControler(width/2,height/2);
}

void draw(){
  background(255);
  fill(0);
  ellipse(player.getX(),player.getY(),10,10);              //draws the dot
  
  inputUpdate();
  //println(keys[0][1],keys[1][1],keys[2][1],keys[3][1]);
  
}

void inputUpdate(){
  for(int i = 0; i < keys.length; i++){
    if(keys[i][0] == 1 && keys[i][1] < speedMax){
      if(!cursorActive){
        keys[i][1] += slide;
      }else{
        keys[i][1] = speedMax*3;
      }
    }else if(keys[i][1] > 0){
      if(!cursorActive){
        keys[i][1] -= slide;
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
