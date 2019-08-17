final class Ratio {
  final float value;

  Ratio(float value) {
    this.value = value;
  }
}

final class ImmutableVector {
  final float x;
  final float y;

  ImmutableVector(float x, float y) {
    this.x = x;
    this.y = y;
  }

  ImmutableVector add(ImmutableVector other) {
    return new ImmutableVector(
      this.x + other.x,
      this.y + other.y
    );
  }

  ImmutableVector sub(ImmutableVector other) {
    return new ImmutableVector(
      this.x - other.x,
      this.y - other.y
    );
  }

  ImmutableVector mult(Ratio multiplier) {
    return new ImmutableVector(
      multiplier.value * this.x,
      multiplier.value * this.y
    );
  }
}

final class LineSegment {
  final ImmutableVector startPoint;
  final ImmutableVector endPoint;

  LineSegment(
    ImmutableVector startPoint,
    ImmutableVector endPoint
  ) {
    this.startPoint = startPoint;
    this.endPoint = endPoint;
  }

  void draw() {
    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  }
}

final class RectangleSize {
  final float width;
  final float height;

  RectangleSize(float w, float h) {
    this.width = w;
    this.height = h;
  }
}

final class Rectangle {
  final ImmutableVector position;
  final RectangleSize size;

  Rectangle(ImmutableVector position, RectangleSize size) {
    this.position = position;
    this.size = size;
  }

  void draw() {
    rect(position.x, position.y, size.width, size.height);
  }
}

final class CyclicCount {
  final int value;
  final int maxValue;

  CyclicCount(int value, int maxValue) {
    this.value = value;
    this.maxValue = maxValue;
  }

  CyclicCount increment() {
    return new CyclicCount((value + 1) % maxValue, maxValue);
  }

  boolean isZero() {
    return this.value == 0;
  }
}
