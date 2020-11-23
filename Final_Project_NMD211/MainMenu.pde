class MainMenu{
  private float x;
  private float y;
  private float mWidth;
  private float mHeight;
  private boolean down;
  private float speed = 18;
  private float startY;
  private String text;
  private Button button;
  private float textS;
  
  
  MainMenu(){
    x = width/2;
    y = height/2;
    mWidth = 500;
    mHeight = 400;
    down = false;
    startY = y;
    speed = 18;
    text = " ";
    button = new Button();
    textS = 30;
  }
  
  MainMenu(float _x, float _y, float w, float h, boolean d, float s, String t, Button b, float ts){
    x = _x;
    y = _y;
    mWidth = w;
    mHeight = h;
    down = d;
    startY = _y;
    speed = s;
    text = t;
    button = b;
    textS = ts;
  }
  
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
  
  Button getButton(){
    return button; 
  }
  
  void display(){
    if(down){
      fill(240,142,44);
      stroke(191,111,31);
      rect(x, y, mWidth, mHeight, 10);
      fill(0);
      textSize(textS);
      text(text, x+mWidth/2, y+mHeight/2);
      button.display();
    }else{
      if(y <= height+200){
         move(1);
      }
      fill(240,142,44);
      stroke(191,111,31);
      rect(x, y, mWidth, mHeight, 10);
      fill(0);
      textSize(textS);
      text(text, x+mWidth/2, y+mHeight/2);
      button.display();
    }
  }
  
  private void move(int dir){
    y += speed*dir;
    button.addY(speed*dir);
  }
}
