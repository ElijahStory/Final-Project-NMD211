class x_yControler{
  private float x;
  private float y;
  
  x_yControler(){
    x = 0;
    y = 0;
  }
  
  x_yControler(float _x, float _y){
    x = _x;
    y = _y;
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
  
  void addX(float value){
    x += value;
    x = constrain(x, 0, width);
  }
  
  void addY(float value){
    y += value;
    y = constrain(y, 0, height);
  }
}
