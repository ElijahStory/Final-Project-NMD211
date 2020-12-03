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
  Serial.println('s');
}

void loop() {
  sensors_event_t accel;
  mpu_accel->getEvent(&accel);
  if (Serial.available() > 0) {

    accel.acceleration.x -= 0.52;
    accel.acceleration.y += 0.0;

    char input = Serial.read();

    Serial.print(accel.acceleration.x,4);
    Serial.print(accel.acceleration.y,4);
  }
}
