final float cs = sqrt(1.0/3.0); // maximum possible velocity
final float csSq = 1.0/3.0; // "speed of sound"
final float csSqSq = csSq * csSq;

final int gridSize = 100;

final PVector gravity = new PVector(0, -cs/6.0);

final int freezeThreshold = 50;

final float erosionThresholdVelocitySq = 0.00001;
final float erosionProbability = 0.25;

final float toppleVelocitySq = erosionThresholdVelocitySq / 2.0;
final float toppleRatio = 1.0/3.0;
final float fallRatio = 1.0/3.0;
final float erodeRatio = 1.0/3.0;

final float epsilon = 0.0001;

final float Csmago = 0.3;
final float CsmagoSq = Csmago * Csmago;

final float relax = 0.75;
final float relaxSq = relax * relax;

final float lambda = 1.0/gridSize;
final float lambdaSq = lambda * lambda;

final float[] t = new float[]{
  4.0/9.0,
  1.0/9.0,
  1.0/36.0,
  1.0/9.0,
  1.0/36.0,
  1.0/9.0,
  1.0/36.0,
  1.0/9.0,
  1.0/36.0
};

final PVector[] Velocities = new PVector[]{
  new PVector(0, 0),
  new PVector(1, 0),
  new PVector(-1, -1),
  new PVector(-1, 0),
  new PVector(1, -1),
  new PVector(0, 1),
  new PVector(-1, 1),
  new PVector(0, -1),
  new PVector(1, 1)
};
