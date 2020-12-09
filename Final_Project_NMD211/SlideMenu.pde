//Elijah Story
//12-8-2020

/*
This class makes a menu that can hold buttons and can travel up and down.
*/

class SlideMenu{
  private float x;                          //menu X
  private float y;                          //menu Y
  private float mWidth;                     //menu width
  private float mHeight;                    //menu height
  private boolean down;                     //is the menu down
  private Button[] items = new Button[0];   //array that holds buttons in menu
  private float speed;                      //speed the menu moves
  private float startY;                     //where the menu is seen
  
  //unassigned menu constructor. makes "empty" menu
  SlideMenu(){
    x = width/2;
    y = height/2;
    mWidth = 500;
    mHeight = 400;
    down = false;
    startY = y;
    speed = 18;
  }
  
  //assigned menu constructor. makes menu based on values passed from user
  SlideMenu(float _x, float _y, float w, float h, boolean d, float s){
    x = _x;
    y = -h;
    mWidth = w;
    mHeight = h;
    down = d;
    startY = _y;
    speed = s;
  }

  //getters and setters
  float getX() {
    return x;
  }

  void setX(float _x) {
    x = _x;
  }

  float getY() {
    return y;
  }

  void setY(float _y) {
    x = _y;
  }

  float getWidth() {
    return mWidth;
  }

  void setWidth(float w) {
    mWidth = w;
  }

  float getHeight() {
    return mHeight;
  }

  void setHeight(float h) {
    mHeight = h;
  }
  
  boolean getDown(){
    return down; 
  }
  
  void setDown(boolean d){
    down = d; 
  }
  
  float getStartY() {
    return startY;
  }

  void setStartY(float _y) {
    startY = _y;
  }
  
  float getSpeed() {
    return speed;
  }

  void setSpeed(float s) {
    speed = s;
  }
  
  Button[] getButton(){
    return items; 
  }
  
  //checks if the menu is out of sight
  boolean isAway(){
    return y <= -mHeight;
  }
  
  //makes a new array 1 bigger than old. moves all items to new array
  private void increaseArray(Button[] old){
     Button[] newArray = new Button[old.length+1];
     for(int i = 0; i < old.length; i++){
       newArray[i] = old[i]; 
     }
     items = newArray;
  }
  
  //adds a new button to the button array
  void addItem(Button item){
    increaseArray(items);          //make array bigger
    items[items.length-1] = item;  //add new button to the last index
  }
  
  //draw the menu
  void display(){
    fill(240,142,44);
    stroke(191,111,31);
    rect(x, y, mWidth, mHeight, 10);        //draws the menu itself
    for(int i = 0; i < items.length; i++){  //draws all the buttons with the menu
      items[i].display(); 
    }
      
    if(down){            //if the menu needs to be DOWN
      if(y <= startY){   //if the menu is not all the way DOWN
        move(1);         //move it DOWN
      }    
    }else{               //if the menu needs to be UP
      if(y >= -mHeight){ //if the menu is not all the way UP
         move(-1);       //move it UP
      }
    }
  }
  
  //moves the menu and all the buttons with it based on the speed and direction
  private void move(int dir){
    y += speed*dir;
    for(int i = 0; i < items.length; i++){
      items[i].addY(speed*dir); 
    }
  }
}
