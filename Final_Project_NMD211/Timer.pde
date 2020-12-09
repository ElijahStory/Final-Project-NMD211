//Elijah Story
//12-8-2020

/*
This is a timer class. The timer counts minutes, seconds, and milliseconds. 
You can start and stop only once. Once the timer is started again, it starts over. 
The class can compare a time of the same format with the time in timer and will return the faster time.
*/

class Timer {
  private float x;          //timer X for display
  private float y;          //timer Y for display
  private float size;       //font size
  private String time;      //time to be displayed
  private float startTime;  //when the timer was started
  private boolean counting; //is the timer counting

  //unassigned timer constructor. makes "empty" timer
  Timer() {
    x = 0;
    y = 0;
    size = 10;
    time = "00:00:00";
    counting = false;
  }

  //assigned timer constructor. makes timer based on values passed from user
  Timer(float _x, float _y, float s) {
    x = _x;
    y = _y;
    size = s;
    time = "00:00:00";
    counting = false;
  }

  //getters and setters
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

  //starts the timer
  void startTime() {
    startTime = millis();  //records current time
    counting = true;       //say timer is running
  }

  void stopTime() {
    counting = false;      //say timer is NOT running
  }
  
  //checks to see if the time stored in timer is faster than provided
  String compare(String check){
    String[] top = split(check,":");  //splits the numbers and stores in array
    String[] cur = split(time,":");   //splits the numbers and stores in array
    if(!check.equals("--:--:--")){    //if the given time is NOT empty
      if(Integer.parseInt(cur[0]) < Integer.parseInt(top[0])){        //check if the timers minutes is faster(less than) given time
        return time;
      }else if(Integer.parseInt(cur[1]) < Integer.parseInt(top[1])){  //check if the timers seconds is faster(less than) given time
        return time;
      }else if(Integer.parseInt(cur[1]) == Integer.parseInt(top[1])){ //must make sure the seconds are same to check milliseconds
        if(Integer.parseInt(cur[2]) < Integer.parseInt(top[2])){      //check if the timers milliseconds is faster(less than) given time
          return time;
        }
      }
        return check;                                                 //the time passed in was faster than timer
    }
    return time;
  }

  //draw the timer
  void display() {
    if (counting) {                                          //if the timer is ON, update
      float curTime = millis();                              //get current time
      String[] temp = split(time, ':');                      //splits the numbers and stores in array
      temp[2] = str(floor((curTime-startTime)/10)%100);      //update milliseconds
      temp[1] = str((int)((curTime-startTime)/1000)%60);     //update seconds
      temp[0] = str((int)((curTime-startTime)/(1000*60))%60);//update minutes
      time = join(temp,":");                                 //turns array back into string 
    }
    fill(0);
    textSize(size);
    text(time, x, y);                                        //display the timer
  }
}
