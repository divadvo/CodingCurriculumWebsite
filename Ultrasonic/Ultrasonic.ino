#include <NewPing.h>

#define TRIGGER_PIN  10
#define ECHO_PIN     11
#define MAX_DISTANCE 200

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

int distanceCM = 0;

void setup() {

}

void loop() {
  delay(50);
  distanceCM = sonar.ping_cm();
}
