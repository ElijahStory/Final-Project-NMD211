class SlideMenu{
  private float x;
  private float y;
  private float mWidth;
  private float mHeight;
  private boolean down;
  private level[] items = new level[0];
  
  
  SlideMenu(){
    x = width/2;
    y = height/2;
    mWidth = 500;
    mHeight = 400;
    down = false;
  }
  
  SlideMenu(float _x, float _y, float w, float h, boolean d){
    x = _x;
    y = _y;
    mWidth = w;
    mHeight = h;
    down = d;
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
  
  private void increaseArray(level[] old){
     level[] newArray = new level[old.length+1];
     for(int i = 0; i < old.length; i++){
       newArray[i] = old[i]; 
     }
     items = newArray;
  }
  
  <T> void addItem(level item){
    increaseArray(items);
    items[items.length-1] = item;
  }
  
  void display(){
    fill(240,142,44);
    stroke(191,111,31);
    rect(x, y, mWidth, mHeight, 10);
    for(int i = 0; i < items.length; i++){
      items[i].display(); 
    }
  }
}
