ParticleGroup particles = new ParticleGroup(32);

void setup(){
  size(800, 800);
  fill(252, 32);
  strokeWeight(8);
}

void draw(){
  rect(0, 0, width, height);

  if (frameCount % 30 == 0) particles.shuffle(width, height);
  particles.update();
  particles.draw();
}
