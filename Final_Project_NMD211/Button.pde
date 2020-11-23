class Button {
  private float x;
  private float y;
  private float bWidth;
  private float bHeight;
  private boolean mouseOver;
  private boolean unlocked;
  private String label;
  private float textS;
  private level levelInfo;

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
  
  void addY(float add){
    y += add; 
  }

  void display() {
    overButton();
    fill(232, 215, 84);
    stroke(206, 186, 31);
    strokeWeight(5);
    textSize(textS);
    rect(x, y, bWidth, bHeight, 10);
    fill(0);
    if (unlocked) {
      text(label, x+(bWidth/2), y+(bHeight/2));
    } else {
      text("Locked", x+(bWidth/2), y+(bHeight/2));
    }

    if (mouseOver) {
      fill(255,30);
      stroke(255,30);
      rect(x, y, bWidth, bHeight, 10);
    }
  }

  boolean buttonClicked() {
    if (unlocked && mouseOver && mousePressed) {
      return true;
    }
    return false;
  }

  private void overButton() {
    if(mouseX >= x && mouseX <= x+bWidth){
      if(mouseY >= y && mouseY <= y+bHeight){
        mouseOver = true;
      }else{
        mouseOver = false;
      }
    }else{
      mouseOver = false;
    }
  }
}
