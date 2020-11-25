class Timer {
  private float x;
  private float y;
  private float size;
  private String time;
  private float startTime;
  private boolean counting;

  Timer() {
    x = 0;
    y = 0;
    size = 10;
    time = "00:00:00";
    counting = false;
  }

  Timer(float _x, float _y, float s) {
    x = _x;
    y = _y;
    size = s;
    time = "00:00:00";
    counting = false;
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

  float getsize() {
    return size;
  }

  void setSize(float s) {
    size = s;
  }

  String getTime() {
    return time;
  }

  void setTime(String t) {
    time = t;
  }

  void startTime() {
    startTime = millis();
    counting = true;
  }

  void stopTime() {
    counting = false;
  }
  
  String compare(String check){
    String[] top = split(check,":");
    String[] cur = split(time,":");
    if(!check.equals("--:--:--")){
      if(Integer.parseInt(cur[0]) < Integer.parseInt(top[0])){
        return time;
      }else if(Integer.parseInt(cur[1]) < Integer.parseInt(top[1])){
        return time;
      }else if(Integer.parseInt(cur[1]) == Integer.parseInt(top[1])){
        if(Integer.parseInt(cur[2]) < Integer.parseInt(top[2])){
          return time;
        }
      }
        return check; 
    }
    return time;
  }

  void display() {
    if (counting) {
      float curTime = millis();
      String[] temp = split(time, ':');
      temp[2] = str(floor((curTime-startTime)/10)%100);
      temp[1] = str((int)((curTime-startTime)/1000)%60);
      temp[0] = str((int)((curTime-startTime)/(1000*60))%60);
      time = join(temp,":");
    }
    fill(0);
    textSize(size);
    text(time, x, y);
  }
}
