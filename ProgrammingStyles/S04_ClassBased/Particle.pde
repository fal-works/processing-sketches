import java.util.List;
import java.util.Arrays;

class LineSegment {
  PVector startPoint;
  PVector endPoint;
  
  LineSegment() {
    startPoint = new PVector();
    endPoint = new PVector();
  }

  void draw() {
    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  }
}

class Particle {
  LineSegment lineSegment;
  PVector targetPoint;
  float easingFactor = 0.25;

  Particle() {
    lineSegment = new LineSegment();
    targetPoint = new PVector();
  }

  void update() {
    lineSegment.startPoint.set(lineSegment.endPoint);

    PVector displacement = targetPoint
      .copy()
      .sub(lineSegment.endPoint)
      .mult(this.easingFactor);

    lineSegment.endPoint.add(displacement);
  }

  void setTargetPosition(float x, float y) {
    targetPoint.set(x, y);
  }

  void draw() {
    lineSegment.draw();
  }
}

class ParticleGroup {
  List<Particle> list;
  
  ParticleGroup(int particleCount) {
    final Particle[] array = new Particle[particleCount];
    for (int i = 0; i < particleCount; i++)
      array[i] = new Particle();
    list = Arrays.asList(array);
  }
  
  void update() {
    for (Particle each : list) each.update();
  }
  
  void shuffle(float maxX, float maxY) {
    for (Particle each : list) each.setTargetPosition(random(maxX), random(maxY));
  }
  
  void draw() {
    for (Particle each : list) each.draw();
  }
}
