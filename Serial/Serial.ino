int a = -500;
int b = 1000;

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.print(a);
  Serial.print(" ");
  Serial.print(b);
  Serial.println();

  a++;
  b--;
}
