/**
 * Author: FAL
 * Date: 2019-08-20
 */

// constants ---------------------------------------------------

final int CANVAS_SIZE = 800;
final color BACKGROUND_COLOR = 0x19FFFFFF;
final int REPETITIONS_PER_FRAME = 3;
final int NUM_PARTICLES = 100;
final float COLOR_MAX_VALUE = 1; // Max value of each color parameter.
final float SATURATION_FACTOR = 1.0;
final float BRIGHTNESS_FACTOR = 1.0;
final float OPAQUENESS_FACTOR = 0.8;
final float PARTICLE_SIZE = 10;
final float POSITION_MAGNITUDE = 300;
final float DELTA_TIME = 0.002;


// calculated constants ----------------------------------------

final float SATURATION = SATURATION_FACTOR * COLOR_MAX_VALUE;
final float BRIGHTNESS = BRIGHTNESS_FACTOR * COLOR_MAX_VALUE;
final float OPAQUENESS = OPAQUENESS_FACTOR * COLOR_MAX_VALUE;


// variable ----------------------------------------------------

float time = 0;


// equations ---------------------------------------------------

float fnX(float alpha, float theta) {
  return cos(alpha * theta);
}

float fnY(float beta, float theta) {
  return sin(beta * theta);
}

float fnAlpha(float t) {
  return 4 - 3 * cos(t);
}

float fnBeta(float t) {
  return 4 - 3 * cos(t / 2);
}

float fnTheta(float normalizedIndex, float t) {
  return TWO_PI * normalizedIndex + t;
}


// sketch ------------------------------------------------------

void settings() {
  size(CANVAS_SIZE, CANVAS_SIZE);
}

void setup() {
  rectMode(CENTER);
  colorMode(HSB, COLOR_MAX_VALUE);
  noStroke();
}

void draw() {
  translate(width / 2, height / 2);

  for (int k = 0; k < REPETITIONS_PER_FRAME; k++) {
    fill(BACKGROUND_COLOR);
    square(0, 0, CANVAS_SIZE);

    // These are common to all particles at a specific time.
    final float alpha = fnAlpha(time);
    final float beta = fnBeta(time);

    for (float i = 0; i < NUM_PARTICLES; i++) {
      final float normalizedIndex = (float)i / NUM_PARTICLES;
      
      final float hue = normalizedIndex * COLOR_MAX_VALUE;
      fill(hue, SATURATION, BRIGHTNESS, OPAQUENESS);

      final float theta = fnTheta(normalizedIndex, time);
      final float x = fnX(alpha, theta);
      final float y = fnY(beta, theta);
      circle(
        POSITION_MAGNITUDE * x, 
        POSITION_MAGNITUDE * y,
        PARTICLE_SIZE
      );
    }

    time += DELTA_TIME;
  }
}
