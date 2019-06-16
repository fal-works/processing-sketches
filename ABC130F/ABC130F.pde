// Constants ------------------------------------------------------

final int LINE_COUNT = 64;
final float LINE_INTERVAL = 10;
final int POSITION_RESOLUTION = 32;
final int HALF_POSITION_RESOLUTION = POSITION_RESOLUTION / 2;

final color backgroundColor = color(255);
final color lineColor = color(128);
final color pointColor = color(64);
final color axisColor = color(224);
final color planeEdgeColor = color(0, 64, 192, 192);
final color planeColor = color(0, 64, 192, 32);


// Global variables ------------------------------------------------------

ViewAngleController viewer;
Line[] lines;
int time = 0;


// Class definition ------------------------------------------------------

final class Line {
  float x = 0;
  float y = 0;
  float z = 0;
  final float initialX;
  final float initialY;
  final float vx;
  final float vy;
  
  Line(int x, int y) {
    this.initialX = (x - HALF_POSITION_RESOLUTION) * LINE_INTERVAL;
    this.initialY = (y - HALF_POSITION_RESOLUTION) * LINE_INTERVAL;
    this.x = this.initialX;
    this.y = this.initialY;
    
    final float threashold = 0.75 * HALF_POSITION_RESOLUTION * LINE_INTERVAL;
    
    if (Math.abs(initialY) < threashold) {
      this.vx = initialX > 0 ? -1 : 1;
      this.vy = 0;
    } else if (Math.abs(initialX) < threashold) {
      this.vx = 0;
      this.vy = initialY > 0 ? -1 : 1;
    } else if (Math.random() < 0.5) {
      this.vx = initialX > 0 ? -1 : 1;
      this.vy = 0;
    } else {
      this.vx = 0;
      this.vy = initialY > 0 ? -1 : 1;
    }
  }
  
  final void update() {
    this.x += 1 * this.vx;    
    this.y += 1 * this.vy;    
    this.z += 1;
  }
  
  final void draw() {
    stroke(lineColor);
    line(initialX, initialY, 0, x, y, z);

    noStroke();
    fill(pointColor);
    pushMatrix();
    translate(x, y, z);
    sphere(1.5);
    popMatrix();
  }
}

// Functions ------------------------------------------------------

final void initialize() {
  final boolean[][] grid = new boolean[POSITION_RESOLUTION][POSITION_RESOLUTION];
  lines = new Line[LINE_COUNT];
  
  int i = 0;
  
  while (i < LINE_COUNT) {
    int x = (int)(Math.random() * POSITION_RESOLUTION);
    int y = (int)(Math.random() * POSITION_RESOLUTION);
    
    if (grid[x][y]) continue;

    grid[x][y] = true;
    lines[i] = new Line(x, y);
    i++;
  }
  
  time = 0;
}

final void updateCamera() {
  viewer.checkKey();
  viewer.applyPerspective();
  viewer.translateCoordinates();
  viewer.rotateCoordinates();
  
  viewer.addZRotationAngle(radians(10));
}

final void drawAxis() {
  stroke(axisColor);
  final float halfAxisLength = HALF_POSITION_RESOLUTION * LINE_INTERVAL;

  for (int x = -HALF_POSITION_RESOLUTION; x <= HALF_POSITION_RESOLUTION; x++) {
    float xPos = LINE_INTERVAL * x;
    line(xPos, -halfAxisLength, 0, xPos, halfAxisLength, 0);
  }

  for (int y = -HALF_POSITION_RESOLUTION; y <= HALF_POSITION_RESOLUTION; y++) {
    float yPos = LINE_INTERVAL * y;
    line(-halfAxisLength, yPos, 0, halfAxisLength, yPos, 0);
  }
}

final void drawLinesAndPlane() {
  float minX = 99999;
  float maxX = 0;
  float minY = 99999;
  float maxY = 0;

  for (int i = 0; i < LINE_COUNT; i++) {
    Line curLine = lines[i];
    curLine.update();
    curLine.draw();
    
    if (curLine.x < minX) minX = curLine.x;    
    if (curLine.x > maxX) maxX = curLine.x;    
    if (curLine.y < minY) minY = curLine.y;    
    if (curLine.y > maxY) maxY = curLine.y;    
  }

  stroke(planeEdgeColor);
  fill(planeColor);
  
  beginShape();
  vertex(minX, minY, time);
  vertex(maxX, minY, time);
  vertex(maxX, maxY, time);
  vertex(minX, maxY, time);
  endShape(CLOSE);
}


// Setup & Draw ------------------------------------------------------

final void setup() {
  size(800, 500, P3D);

  hint(DISABLE_DEPTH_TEST); 

  // prepare view angle controller
  viewer = new ViewAngleController(radians(75.0), radians(15.0), PI / 3.0, QUARTER_PI, 60, 100.0);
  viewer.addMouseDragChecker(new HorizontalMouseDragChecker(new AddZRotation(), -0.3));
  viewer.addMouseDragChecker(new VerticalMouseDragChecker(new AddXRotation(), -0.3));
  viewer.addKeyCodeChecker(new KeyCodeChecker(UP, new AddFieldOfViewAngle(), -1.0));
  viewer.addKeyCodeChecker(new KeyCodeChecker(DOWN, new AddFieldOfViewAngle(), +1.0));
  
  initialize();
}

final void draw() {
  background(backgroundColor);
  updateCamera();
  drawAxis();

  time++;
  drawLinesAndPlane();
}

final void mouseDragged() {
  viewer.processMouseDragged();
}

final void keyPressed() {
  if (key == ' ') initialize();
}
