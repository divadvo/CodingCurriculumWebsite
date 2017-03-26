import processing.serial.*;

Serial serialPort;

void setup() {
  String portName = Serial.list()[1];
  serialPort = new Serial(this, portName, 9600);
  serialPort.bufferUntil('\n'); // The last character Arduino sends, is newline character
}

void draw() {
  while (serialPort.available() > 0) {
    String receivedString = serialPort.readStringUntil('\n');

    // If received something
    if (receivedString != null) {
      processSerialInput(receivedString);
    }
  }
}

void processSerialInput(String receivedString) {
  float[] nums = float(split(receivedString, ' '));

  float a = nums[0];
  float b = nums[1];

  println("a=" + a + " b=" + b);
}
