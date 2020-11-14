//Elijah Story
//11-14-2020
//key press example

//This is an example of how you could get multiple key inputs at the same time. 
//I am hoping to use the same array to accept multiple inputs.

//Inspiration from: https://forum.processing.org/two/discussion/22644/two-keys-pressed-three-keys-pressed-simultaneously


float x;                   //the x cords of the dot 
float y;                   //the y cords of the dot
float[] keys = {0,0,0,0};  //index order 0=w, 1=a, 2=s, 3=d
float speed = 2;           //speed the dot moves

void setup(){
  size(800,800);
  
  x = width/2;             //starting in the midle of screen
  y = height/2;            //starting in the midle of screen
}

void draw(){
  background(255);
  fill(0);
  ellipse(x,y,10,10);              //draws the dot
  
  if(keys[0] != 0){y -= keys[0];}  //if the w key is pressed
  if(keys[1] != 0){x -= keys[1];}  //if the a key is pressed
  if(keys[2] != 0){y += keys[2];}  //if the s key is pressed
  if(keys[3] != 0){x += keys[3];}  //if the d key is pressed
}

//updates the array based on the key press
void keyPressed(){
   if(key == 'w'){keys[0] = speed;}  
   if(key == 'a'){keys[1] = speed;}
   if(key == 's'){keys[2] = speed;}
   if(key == 'd'){keys[3] = speed;}
}

//updates the array based on the key release
void keyReleased(){
   if(key == 'w'){keys[0] = 0;}
   if(key == 'a'){keys[1] = 0;}
   if(key == 's'){keys[2] = 0;}
   if(key == 'd'){keys[3] = 0;}
}
