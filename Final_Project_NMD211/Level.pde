class level{
  private String levelName;
  private boolean unlocked;
  private String completeTime;
  private int holeAmount;
  private float[][] holes;
  private Button button;
  private float startX;
  private float startY;
  private float endX;
  private float endY;
  
  
  level(){
    levelName = "empty";
    unlocked = false;
    completeTime = "00:00";
    holeAmount = 0;
    holes = new float[holeAmount][2];
    button = new Button();
    startX = 0;
    startY = 0;
    endX = 100;
    endY = 100;
  }
  
  level(String N, boolean UL, String CT, int AH, float[][] H, Button b, float SX, float SY, float EX, float EY){
    levelName = N;
    unlocked = UL;
    completeTime = CT;
    holeAmount = AH;
    holes = H;
    button = b;
    startX = SX;
    startY = SY;
    endX = EX;
    endY = EY;
  }
  
  String getLName(){
    return levelName; 
  }
  
  void setLName(String name){
    levelName = name;
  }
  
  boolean getUnlocked(){
    return unlocked; 
  }
  
  void setUnlocked(boolean status){
    unlocked = status; 
  }
  
  String getTime(){
    return completeTime; 
  }
  
  void setTime(String time){
    completeTime = time; 
  }
  
  int getHoleAmount(){
    return holeAmount; 
  }
  
  float[][] getHoles(){
    return holes; 
  }
  
  void setHoles(float[][] newHoles){
    holes = newHoles; 
  }
  
  float getStartX(){
    return startX; 
  }
  
  void setStartX(float x){
    startX = x; 
  }
  
  float getStartY(){
    return startY; 
  }
  
  void setStartY(float y){
    startY = y; 
  }
  
  float getEndX(){
    return endX; 
  }
  
  void setEndX(float x){
    endX = x; 
  }
  
  float getEndY(){
    return endY; 
  }
  
  void setEndY(float y){
    endY = y; 
  }
  
  Button getButton(){
    return button; 
  }
  
  void display(){
    button.display(); 
  }
}
