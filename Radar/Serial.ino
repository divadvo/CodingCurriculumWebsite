int a = -1000;
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
