class level{
  private String levelName;
  private boolean unlocked;
  private String completeTime;
  private int holeAmount;
  private float[][] holes;
  private Button button;
  
  level(){
    levelName = "empty";
    unlocked = false;
    completeTime = "00:00";
    holeAmount = 0;
    holes = new float[holeAmount][2];
    button = new Button();
  }
  
  level(String N, boolean UL, String CT, int AH, float[][] H){
    levelName = N;
    unlocked = UL;
    completeTime = CT;
    holeAmount = AH;
    holes = H;
    button = new Button();
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
  
  void display(){
    button.display(); 
  }
}
