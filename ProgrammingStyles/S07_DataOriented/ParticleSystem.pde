interface Process {
  void run(
    int i,
    float[] x,
    float[] y,
    float[] targetX,
    float[] targetY
  );
}

class ParticleSystem {
  static final int PARTICLE_COUNT = 32;
  
  final float[] x = new float[PARTICLE_COUNT];
  final float[] y = new float[PARTICLE_COUNT];
  final float[] targetX = new float[PARTICLE_COUNT];
  final float[] targetY = new float[PARTICLE_COUNT];

  final void runProcess(Process process) {
    final float[] x = this.x, y = this.y;
    final float[] targetX = this.targetX, targetY = this.targetY;

    for (int i = 0; i < PARTICLE_COUNT; i++)
      process.run(i, x, y, targetX, targetY);
  }
}
