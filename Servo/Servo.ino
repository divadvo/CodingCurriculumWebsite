#include <Servo.h>

#define SERVO_PIN 12

Servo servo;
int angle = 0;

void setup() {
  servo.attach(SERVO_PIN);
}

void loop() {
  for(angle = 0; angle <= 180; angle++) {
    servo.write(angle);
    delay(15);
  }

  for(angle = 180; angle >= 0; angle--) {
    servo.write(angle);
    delay(15);
  }

}
