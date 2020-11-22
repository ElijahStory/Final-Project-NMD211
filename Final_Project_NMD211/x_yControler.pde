class x_yControler{
  private float x;
  private float y;
  private String id;
  
  x_yControler(){
    x = 0;
    y = 0;
    id = "empty";
  }
  
  x_yControler(float _x, float _y, String _id){
    x = _x;
    y = _y;
    id = _id;
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
  
  public String getId(){
    return id; 
  }
  
  void setId(String _id){
    id = _id; 
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
    return x+" "+y+" "+id; 
  }
}
