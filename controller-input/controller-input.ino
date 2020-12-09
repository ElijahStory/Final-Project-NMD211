//Elijah Story
//12-9-2020
//NMD211

/*
 * 90% of the code was taken from the plotter file in the Adafruit MPU6050 tab in the examples.
 * The code I needed was striped from the plotter. The code takes the acceleration values and adjusts 
 * them based on a manual zeroing process. The values I used may not be the best for all devices. Once the data is zeroed, 
 * it is sent to the Serial with a tab separating the two values. Once the last value is sent, 
 * it adds a new line character to the Serial. This lets Processing know that both the X and Y values are done being sent. 
 */

#include <Adafruit_MPU6050.h>

Adafruit_MPU6050 mpu;
Adafruit_Sensor *mpu_accel;

void setup(void) {
  Serial.begin(9600);
  while (!Serial)
    delay(10); // will pause Zero, Leonardo, etc until serial console opens

  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  mpu_accel = mpu.getAccelerometerSensor();
  Serial.println('s');      //tells processing it is ready
}

void loop() {
  sensors_event_t accel;
  mpu_accel->getEvent(&accel);
  if (Serial.available() > 0){              //if processing has asked for data

    accel.acceleration.x -= 0.52;           //zero the X value
    accel.acceleration.y += 0.0;            //zero the Y value

    char input = Serial.read();             //throw away processings request signal 

    Serial.print(accel.acceleration.x,2);   //send the X value
    Serial.print('\t');                     //add tab separating values
    Serial.println(accel.acceleration.y,2); //send the Y value
  }
}
