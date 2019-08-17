
const createLineSegment = () => {
  return { start: createVector(), end: createVector(),  };
};
const createParticle = () => {
  return {
    lineSegment: createLineSegment(),
    targetPoint: createVector(),
  };
};
const createParticles = count =>
  Array.from(Array(count), createParticle);

const distance = (current, target) =>
  p5.Vector.sub(target, current);
const easingFactor = 0.25;
const displacement = (current, target) =>
  p5.Vector.mult(distance(current, target), easingFactor);
const nextPoint = (current, target) =>
  p5.Vector.add(current, displacement(current, target));
const nextLineSegment = (currentPoint, targetPoint) => {
  return {
    start: currentPoint,
    end: nextPoint(currentPoint, targetPoint),
  };
};

const changeTargetPoint = particle => newTarget => {
  return {
    lineSegment: particle.lineSegment,
    targetPoint: newTarget,
  };
};

const updateParticle = particle => {
  return {
    lineSegment: nextLineSegment(
      particle.lineSegment.end,
      particle.targetPoint
    ),
    targetPoint: particle.targetPoint,
  };
};

// ----

const randomPoint = () =>
  createVector(random(width), random(height));
const drawLineSegment = seg =>
  line(seg.start.x, seg.start.y, seg.end.x, seg.end.y);

let particles;

function setup() {
  createCanvas(800, 800);
  fill(252, 32);
  strokeWeight(8);
  particles = createParticles(32);
};

function draw() {
  rect(0, 0, width, height);

  if (frameCount % 30 === 0) {
    particles = particles
      .map(changeTargetPoint)
      .map(f => f(randomPoint()));
  }

  particles = particles.map(updateParticle);

  particles
    .map(particle => particle.lineSegment)
    .forEach(drawLineSegment);
}
