class x_yControler{
  private float x;
  private float y;
  private String name;
  
  x_yControler(){
    x = 0;
    y = 0;
    name = "empty";
  }
  
  x_yControler(float _x, float _y, String _name){
    x = _x;
    y = _y;
    name = _name;
  }
  
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
  
  public String getName(){
    return name; 
  }
  
  void setName(String _name){
    name = _name; 
  }
  
  void addX(float value){
    x += value;
    x = constrain(x, 0, width);
  }
  
  void addY(float value){
    y += value;
    y = constrain(y, 0, height);
  }
  
  String toString(){
    return x+" "+y+" "+name; 
  }
}
