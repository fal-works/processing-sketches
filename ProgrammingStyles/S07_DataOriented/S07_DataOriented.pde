final Process selectProcess() {
  return frameCount % 30 == 0 ? shuffleAndDraw : updateAndDraw;
}

final ParticleSystem system = new ParticleSystem();

final void setup() {
  size(800, 800);
  fill(252, 32);
  strokeWeight(8);
}

final void draw(){
  square(0, 0, 800);
  system.runProcess(selectProcess());
}
