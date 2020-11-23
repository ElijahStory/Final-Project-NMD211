class SlideMenu{
  private float x;
  private float y;
  private float mWidth;
  private float mHeight;
  private boolean down;
  private Button[] items = new Button[0];
  private float speed = 18;
  private float startY;
  
  
  SlideMenu(){
    x = width/2;
    y = height/2;
    mWidth = 500;
    mHeight = 400;
    down = false;
    startY = y;
    speed = 18;
  }
  
  SlideMenu(float _x, float _y, float w, float h, boolean d, float s){
    x = _x;
    y = -h;
    mWidth = w;
    mHeight = h;
    down = d;
    startY = _y;
    speed = s;
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
  
  Button[] getButton(){
    return items; 
  }
  
  boolean isAway(){
    return y <= -mHeight;
  }
  
  private void increaseArray(Button[] old){
     Button[] newArray = new Button[old.length+1];
     for(int i = 0; i < old.length; i++){
       newArray[i] = old[i]; 
     }
     items = newArray;
  }
  
  void addItem(Button item){
    increaseArray(items);
    items[items.length-1] = item;
  }
  
  void display(){
    if(down){
      if(y <= startY){
        move(1); 
      }
      fill(240,142,44);
      stroke(191,111,31);
      rect(x, y, mWidth, mHeight, 10);
      for(int i = 0; i < items.length; i++){
        items[i].display(); 
      }
    }else{
      if(y >= -mHeight){
         move(-1);
      }
      fill(240,142,44);
      stroke(191,111,31);
      rect(x, y, mWidth, mHeight, 10);
      for(int i = 0; i < items.length; i++){
        items[i].display(); 
      }
    }
  }
  
  private void move(int dir){
    y += speed*dir;
    for(int i = 0; i < items.length; i++){
      items[i].addY(speed*dir); 
    }
  }
}
