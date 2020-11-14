class player{
  private float x;
  private float y;
  
  player(){
    x = 0;
    y = 0;
  }
  
  player(float _x, float _y){
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
  }
  
  void addY(float value){
    y += value;
  }
}
