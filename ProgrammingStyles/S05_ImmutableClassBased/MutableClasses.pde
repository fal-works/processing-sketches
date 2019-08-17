import java.util.List;
import java.util.Arrays;

class Particle {
  LineSegment lineSegment;
  ImmutableVector targetPoint;

  Particle() {
    lineSegment = ZERO_LINE_SEGMENT;
    targetPoint = ZERO_VECTOR;
  }

  void update() {
    ImmutableVector displacement = targetPoint
      .sub(lineSegment.endPoint)
      .mult(EASING_FACTOR);

    lineSegment = new LineSegment(
      lineSegment.endPoint,
      lineSegment.endPoint.add(displacement)
    );
  }

  void setTargetPosition(float x, float y) {
    targetPoint = new ImmutableVector(x, y);
  }

  void draw() {
    lineSegment.draw();
  }
}

class ParticleGroup {
  final List<Particle> list;

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
    for (Particle each : list)
      each.setTargetPosition(random(maxX), random(maxY));
  }

  void draw() {
    for (Particle each : list) each.draw();
  }
}
