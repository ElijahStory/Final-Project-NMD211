//Elijah Story
//12-8-2020

/*
This class just holds the X, Y, and id of an object that will move on screen. 
The X and Y values can be updated. The X and Y values are maintained to stay within the bounds of the screen.
*/

class x_yControler{
  private float x;      //controler X
  private float y;      //controler Y
  private String id;    //controler id
  
  //unassigned controler constructor. makes "empty" controler
  x_yControler(){
    x = 0;
    y = 0;
    id = "empty";
  }
  
  //assigned controler constructor. makes controler based on values passed from user
  x_yControler(float _x, float _y, String _id){
    x = _x;
    y = _y;
    id = _id;
  }
  
  //getters and setters
  float getX(){
    return x; 
  }
  
  void setX(float _x){
    x = _x;
  }
  
  float getY(){
    return y; 
  }
  
  void setY(float _y){
    y = _y;
  }
  
  public String getId(){
    return id; 
  }
  
  void setId(String _id){
    id = _id; 
  }
  
  //updates the X cord. Makes sure the X cord stays on screen
  void addX(float value){
    x += value;
    x = constrain(x, 0, width);
  }
  
  //updates the Y cord. Makes sure the Y cord stays on screen
  void addY(float value){
    y += value;
    y = constrain(y, 0, height);
  }
}
