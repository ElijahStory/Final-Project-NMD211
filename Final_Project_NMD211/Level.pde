//Elijah Story
//12-8-2020

/*
This level class stores all the info associated with the level. This includes the name of the level, 
if the level is unlocked, the fastest time the level was completed, the number of holes in the level, 
an array of the X and Y coordinates for each hole, the start X and Y position for the player, 
the end X and Y position for the end target, and the index of the level in the list of levels.
*/

class level{
  private String levelName;      //level name
  private boolean unlocked;      //level unlocked status
  private String completeTime;   //fastest time the level was completed
  private int holeAmount;        //number of holes in the level
  private float[][] holes;       //X and Y coordinates for each hole
  private float startX;          //start X position for the player
  private float startY;          //start Y position for the player
  private float endX;            //end X position for the end target
  private float endY;            //end Y position for the end target
  private int levelIndex;        //index of the level in the list of levels
  
  //unassigned level constructor. makes "empty" level
  level(){
    levelName = "empty";
    unlocked = false;
    completeTime = "--:--:--";
    holeAmount = 0;
    holes = new float[holeAmount][2];
    startX = 0;
    startY = 0;
    endX = 100;
    endY = 100;
    levelIndex = 0;
  }
  
  //assigned level constructor. makes level based on values passed from user
  level(String N, boolean UL, String CT, int AH, float[][] H, float SX, float SY, float EX, float EY, int LI){
    levelName = N;
    unlocked = UL;
    completeTime = CT;
    holeAmount = AH;
    holes = H;
    startX = SX;
    startY = SY;
    endX = EX;
    endY = EY;
    levelIndex = LI;
  }
  
  //getters and setters
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
  
  int getLevelIndex(){
    return levelIndex; 
  }
  
  void setLevelIndex(int index){
    levelIndex = index; 
  }
}
