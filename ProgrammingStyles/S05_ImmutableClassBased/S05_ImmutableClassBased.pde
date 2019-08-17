final ImmutableVector ZERO_VECTOR = new ImmutableVector(0, 0);
final LineSegment ZERO_LINE_SEGMENT = new LineSegment(ZERO_VECTOR, ZERO_VECTOR);
final Ratio EASING_FACTOR = new Ratio(0.25);

final ParticleGroup particles = new ParticleGroup(32);
Rectangle canvasRectangle;
CyclicCount count = new CyclicCount(0, 30);

void setup(){
  size(800, 800);
  fill(252, 32);
  strokeWeight(8);

  canvasRectangle = new Rectangle(
    new ImmutableVector(0, 0),
    new RectangleSize(width, height)
  );
}

void draw(){
  canvasRectangle.draw();

  if (count.isZero()) particles.shuffle(width, height);
  particles.update();
  particles.draw();
  
  count = count.increment();
}
