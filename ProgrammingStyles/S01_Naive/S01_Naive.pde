float[] x = new float[32];
float[] y = new float[32];
float[] targetX = new float[32];
float[] targetY = new float[32];

void setup() {
  size(800, 800);
  fill(252, 32);
  strokeWeight(8);
}

void draw() {
  rect(0, 0, width, height);

  for (int i = 0; i < 32; i++) {
    if (frameCount % 30 == 0) {
      targetX[i] = random(width);
      targetY[i] = random(height);
    }
    
    float previousX = x[i];
    float previousY = y[i];
    float nextX = x[i] + (targetX[i] - x[i]) / 4;
    float nextY = y[i] + (targetY[i] - y[i]) / 4;
    
    line(previousX, previousY, nextX, nextY);
    
    x[i] = nextX;
    y[i] = nextY;
  }
}
