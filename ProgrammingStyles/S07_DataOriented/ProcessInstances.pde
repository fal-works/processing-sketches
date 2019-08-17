final float ease(
  float currentValue,
  float targetValue,
  float easingFactor
) {
  return currentValue + easingFactor * (targetValue - currentValue);
}

final float EASING_FACTOR = 0.25;


final Process updateAndDraw = new Process() {
  final void run(
    int i,
    float[] x,
    float[] y,
    float[] targetX,
    float[] targetY
  ) {
    line(
      x[i],
      y[i],
      x[i] = ease(x[i], targetX[i], EASING_FACTOR),
      y[i] = ease(y[i], targetY[i], EASING_FACTOR)
    );
  }
};

final Process shuffleAndDraw = new Process() {
  final void run(
    int i,
    float[] x,
    float[] y,
    float[] targetX,
    float[] targetY
  ) {
    targetX[i] = random(width);
    targetY[i] = random(height);
    updateAndDraw.run(i, x, y, targetX, targetY);
  }
};
