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

  void display() {
    if (counting) {
      float curTime = millis();
      String[] temp = split(time, ':');
      temp[2] = str(floor(curTime-startTime/1000));
      temp[1] = str((int)(Integer.parseInt(temp[2])%60));
      temp[0] = str((int)(Integer.parseInt(temp[1])%60));
      time = join(temp,":");
    }
    fill(0);
    textSize(size);
    text(time, x, y);
  }
}
