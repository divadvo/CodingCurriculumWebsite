import processing.serial.*;

int angle = 0;
int distanceCM = 0;
color textColor = color(200, 200, 0);
color colorRadar = color(39, 174, 96);
Serial serialPort;

void setup() {
  size(1280, 720);
  smooth();

  //serialPort = new Serial(this, "COM4", 9600);
  //serialPort.bufferUntil('\n');
}

void draw() {
  angle++;
  if (angle > 180)
    angle = 0;
  //angle = floor(map(mouseX, 0, width, 180, 0));

  distanceCM = floor(random(500, 600));
  //distanceCM = floor(map(mouseY, 0, height, 1200, 0));

  motionBlurAndFade();
  drawRadar();
  drawCurrentScanningLine();
  drawObject();
  drawInfo();
}

void serialEvent (Serial serialPort) {
  // TODO: implement
}

void motionBlurAndFade() {
  noStroke();
  fill(0, 4);
  //fill(51);
  rect(0, 0, width, height - 70);
}

void drawRadar() {
  pushMatrix();

  translate(width / 2, height - 70);
  noFill();
  strokeWeight(2);
  stroke(colorRadar);


  textSize(12);
  for (int i = 300; i <= 1300; i += 150)
    drawRadarArc(i);
  for (int i = 0; i <= 180; i += 30)
    drawRadarLine(i, 600);

  popMatrix();
}

void drawRadarLine(int angle, int len) {
  line(0, 0, len * cos(radians(angle)), -len * sin(radians(angle)));

  fill(50, 255, 80);
  textAlign(CENTER, BOTTOM);
  text("" + angle + "°", (len + 15) * cos(radians(angle)), -(len + 15) * sin(radians(angle))); 
  noFill();
}

void drawRadarArc(int diameter) {
  arc(0, 0, diameter, diameter, PI, TWO_PI);

  fill(textColor);
  textAlign(CENTER, CENTER);
  text("" + diameter + "cm", diameter/2, -20); 
  text("" + diameter + "cm", -diameter/2, -20); 
  noFill();
}

void drawCurrentScanningLine() {
  pushMatrix();
  translate(width / 2, height - 70);

  strokeWeight(2);
  stroke(241, 196, 15);
  line(0, 0, 0.9 * height * cos(radians(angle)), 0.9 * -height * sin(radians(angle)));

  popMatrix();
}

void drawInfo() {
  fill(0);
  noStroke();
  rect(0, height - 68, width, 68);
  pushMatrix();
  translate(width / 2, height - 20);

  fill(240, 50, 30);
  textSize(25);
  textAlign(LEFT, CENTER);
  text("Angle: " + angle, 100, 0);
  text("Distance: " + distanceCM, 300, 0);

  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - 70);
  stroke(255, 10, 10); 
  int pixsDistance = distanceCM / 2;
  if (distanceCM < 1000)
    line(pixsDistance * cos(radians(angle)), -pixsDistance * sin(radians(angle)), 0.9 * height * cos(radians(angle)), 0.9 * -height * sin(radians(angle)));
  popMatrix();
}