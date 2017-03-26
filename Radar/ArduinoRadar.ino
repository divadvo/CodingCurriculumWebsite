#include <NewPing.h>
#include <Servo.h>

#define TRIGGER_PIN  12
#define ECHO_PIN     11
#define MAX_DISTANCE 500
#define SERVO_PIN 10
#define LED_PIN 13

Servo servo;
int angle = 0;

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
int distanceCM = 0;

void setup() {
  servo.attach(SERVO_PIN);
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(115200);
}

void loop() {
  for (angle = 0; angle <= 180; angle++) {
    measureDistance(angle);
  }

  for (angle = 180; angle >= 0; angle--) {
    measureDistance(angle);
  }
}

void measureDistance(int angle) {
  servo.write(angle);
  delay(50);
  distanceCM = sonar.ping_cm();

  if (distanceCM < 100)
    digitalWrite(LED_PIN, HIGH);
  else
    digitalWrite(LED_PIN, LOW);
  
  Serial.print(angle);
  Serial.print(" ");
  Serial.print(distanceCM);
  Serial.println();
}

