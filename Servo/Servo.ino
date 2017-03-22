#include <Servo.h> //Imports the code needed to use the servo

#define SERVO_PIN 9 //Sets a variable for the servo pin

Servo servo; //Initialises the servo 
int angle = 0; //Sets the starting angle to 0

void setup() {
  servo.attach(SERVO_PIN); //links pin number 9 to the inistialised servo  
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
