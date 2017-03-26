import processing.serial.*;

float SCALE = 6;
int angle = 0;
int distanceCM = 0;
color textColor = color(200, 200, 0);
color colorRadar = color(39, 174, 96);
color radarLineColor = color(50, 255, 80);
color infoColor = color(240, 50, 30);
color scanningColor = color(241, 196, 15);
color objectDetectedColor = color(255, 10, 10);
Serial serialPort;

void setup() {
  size(1280, 720);
  smooth();

  serialPort = new Serial(this, Serial.list()[1], 115200);
  serialPort.bufferUntil('\n');
}

void draw() {
  receive();

  motionBlurAndFade();
  drawRadar();
  drawCurrentScanningLine();
  drawObject();
  drawInfo();
}

void receive() {
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

  if (nums.length > 0)
    angle = int(nums[0]);
  if (nums.length > 1)
    distanceCM = int(nums[1]);
}

void motionBlurAndFade() {
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height - 70);
}

void drawRadar() {
  pushMatrix();

  translate(width / 2, height - 70);
  noFill();
  strokeWeight(2);
  stroke(colorRadar);


  textSize(12);
  for (int i = 50; i <= 200; i += 50)
    drawRadarArc(i);
  for (int i = 0; i <= 180; i += 30)
    drawRadarLine(i, 600);

  popMatrix();
}

void drawRadarLine(int angle, int len) {
  line(0, 0, len * cos(radians(angle)), -len * sin(radians(angle)));

  fill(radarLineColor);
  textAlign(CENTER, BOTTOM);
  text("" + angle + "°", (len + 15) * cos(radians(angle)), -(len + 15) * sin(radians(angle)));
  noFill();
}

void drawRadarArc(int diameter) {
  int scaledDiameter = (int)(diameter * SCALE);
  arc(0, 0, scaledDiameter, scaledDiameter, PI, TWO_PI);

  fill(textColor);
  textAlign(CENTER, CENTER);
  text("" + diameter + "cm", scaledDiameter/2, -20);
  text("" + diameter + "cm", -scaledDiameter/2, -20);
  noFill();
}

void drawCurrentScanningLine() {
  pushMatrix();
  translate(width / 2, height - 70);

  strokeWeight(2);
  stroke(scanningColor);
  line(0, 0, 0.9 * height * cos(radians(angle)), 0.9 * -height * sin(radians(angle)));

  popMatrix();
}

void drawInfo() {
  fill(0);
  noStroke();
  rect(0, height - 68, width, 68);
  pushMatrix();
  translate(width / 2, height - 20);

  fill(infoColor);
  textSize(25);
  textAlign(LEFT, CENTER);
  text("Angle: " + angle, 100, 0);
  text("Distance: " + distanceCM, 300, 0);

  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - 70);
  stroke(objectDetectedColor);
  int pixsDistance = (int)(distanceCM * SCALE / 2);
  if (distanceCM < 100)
    line(pixsDistance * cos(radians(angle)), -pixsDistance * sin(radians(angle)), 0.9 * height * cos(radians(angle)), 0.9 * -height * sin(radians(angle)));
  popMatrix();
}
