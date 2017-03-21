#define LED_PIN 13

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  // Turn on for 2 seconds
  digitalWrite(LED_PIN, HIGH); 
  delay(2000);

  // Turn off for 1 second
  digitalWrite(LED_PIN, LOW);
  delay(1000);
}
