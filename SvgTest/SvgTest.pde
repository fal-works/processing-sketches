import processing.svg.PGraphicsSVG;

boolean recording = false;

void setup() {
  size(640, 480);
}

void draw() {
  background(255);
  
  if (recording) {
    drawAndSave();
    recording = false;
  } else {
    drawWithoutSave();
  }
}

void drawWithoutSave() {
  noStroke();
  fill(0, 200, 250);
  ellipse(width/2, height/2, 100, 100);
}

void drawAndSave() {
  beginRecord(SVG, "PApplet.svg");
  drawWithoutSave();
  endRecord();
}

void mousePressed() {
  recording = true;
}
