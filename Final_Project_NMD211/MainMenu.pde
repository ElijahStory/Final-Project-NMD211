//Elijah Story
//12-8-2020

/*
This class is used just to make main menus that are shown once and that's it. 
It has one button to begin the game. It has text explaining how the game is played. 
It can be made to any size.
*/

class MainMenu{
  private float x;            //the X of the menu
  private float y;            //the current Y of the menu
  private float mWidth;       //the menu width
  private float mHeight;      //the menu height
  private boolean down;       //is the menu down
  private float speed = 18;   //the speed the menu moves
  private String text;        //the message on the menu
  private Button button;      //the start button
  private float textS;        //the font size
  
  //unassigned menu constructor. makes "empty" menu
  MainMenu(){
    x = width/2;
    y = height/2;
    mWidth = 500;
    mHeight = 400;
    down = false;
    speed = 18;
    text = " ";
    button = new Button();
    textS = 30;
  }
  
  //assigned menu constructor. makes meun based on values passed from user
  MainMenu(float _x, float _y, float w, float h, boolean d, float s, String t, Button b, float ts){
    x = _x;
    y = _y;
    mWidth = w;
    mHeight = h;
    down = d;
    speed = s;
    text = t;
    button = b;
    textS = ts;
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
  
  float getSpeed() {
    return speed;
  }

  void setSpeed(float s) {
    speed = s;
  }
  
  Button getButton(){
    return button; 
  }
  
  //draws the menu
  void display(){
    fill(240,142,44);
    stroke(191,111,31);
    rect(x, y, mWidth, mHeight, 10);      //the menu itself
    fill(0);
    textSize(textS);
    text(text, x+mWidth/2, y+mHeight/2);  //text on menu
    button.display();                     //draw the button on menu
    
    if(!down){                            //if the button is not down, move menu down until out of sight
      if(y <= height+200){
         move(1);
      }
    }
  }
  
  //updates the menus Y and the buttons Y
  private void move(int dir){
    y += speed*dir;
    button.addY(speed*dir);
  }
}
