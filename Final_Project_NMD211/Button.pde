//Elijah Story
//12-8-2020

/*
This class makes buttons that can be clicked. The button can be given a X and Y coordinates as well as Height and Width. 
The button has a locked feature. The button will display a highlighting effect if the mouse is over the button. 
The button holds the level it represents.
*/

class Button {
  private float x;              //the buttons X cord
  private float y;              //the buttons Y cord
  private float bWidth;         //the width of the button
  private float bHeight;        //the height of the button
  private boolean mouseOver;    //is the mouse over the button
  private boolean unlocked;     //is the button unlocked
  private String label;         //the label on the button
  private float textS;          //the font size
  private level levelInfo;      //the level data it remersents

  //unassigned button constructor. makes "empty" button
  Button() {
    x = width/2;
    y = height/2;
    bWidth = 100;
    bHeight = 40;
    mouseOver = false;
    unlocked = false;
    label = " ";
    textS = 30;
    levelInfo = null;
  }
  
  //assigned button constructor. makes button based on values passed from user
  Button(float _x, float _y, float w, float h, boolean UL, String _label, float ts, level li) {
    x = _x;
    y = _y;
    bWidth = w;
    bHeight = h;
    mouseOver = false;
    unlocked = UL;
    label = _label;
    textS = ts;
    levelInfo = li;
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
    return bWidth;
  }

  void setWidth(float w) {
    bWidth = w;
  }

  float getHeight() {
    return bHeight;
  }

  void setHeight(float h) {
    bHeight = h;
  }

  boolean getMouseOver() {
    return mouseOver;
  }

  void setMouseOver(boolean mouseStatus) {
    mouseOver = mouseStatus;
  }

  boolean getUnlocked() {
    return unlocked;
  }

  void setUnlocked(boolean UL) {
    unlocked = UL;
  }

  String getLabel() {
    return label;
  }

  void setLabel(String _label) {
    label = _label;
  }
  
  level getLevel(){
    return levelInfo; 
  }
  
  void setLevel(level l){
    levelInfo = l; 
  }
  
  //updates the buttons X
  void addX(float add){
    x += add; 
  }
  
  //updates the buttons Y
  void addY(float add){
    y += add; 
  }

  //draws the button
  void display() {
    overButton();        //checks if mouse over button
    fill(232, 215, 84);
    stroke(206, 186, 31);
    strokeWeight(5);
    textSize(textS);
    rect(x, y, bWidth, bHeight, 10);  //draws the button
    fill(0);
    if (unlocked) {                   //displays diffrent label based on unlock status
      text(label, x+(bWidth/2), y+(bHeight/2));    //unlocked
    } else {
      text("Locked", x+(bWidth/2), y+(bHeight/2)); //locked
    }

    if (mouseOver) {  //if the mouse is over button, add over affect
      fill(255,30);
      stroke(255,30);
      rect(x, y, bWidth, bHeight, 10);  //draws box same size as button to add affect
    }
  }

  //checks if the button has been clicked
  boolean buttonClicked() {
    if (unlocked && mouseOver && mousePressed) { //if the mouse is over the button and the mouse is clicked
      return true;                               //button pressed
    }
    return false;                                //button NOT pressed
  }
  
  //checks if the mouse is over the button
  private void overButton() {
    if(mouseX >= x && mouseX <= x+bWidth){      //if the mouse X is within button X bounds
      if(mouseY >= y && mouseY <= y+bHeight){   //if the mouse Y is within button Y bounds
        mouseOver = true;                       //mouse is over
      }else{
        mouseOver = false;                      //mouse NOT is over
      }
    }else{
      mouseOver = false;                        //mouse NOT is over
    }
  }
}
