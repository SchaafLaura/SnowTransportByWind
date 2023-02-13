float Density(int x, int y) {
  float sum = 0;
  for (int i = 0; i < numWeights; i++)
    sum += wind[x][y][i];
  return sum;
}

PVector Velocity(int x, int y) {
  float d = Density(x, y);
  PVector sum = new PVector(0, 0);
  for (int i = 1; i < numWeights; i++)
    sum.add(PVector.mult(Velocities[i], wind[x][y][i]));
  return PVector.mult(sum, 1.0/d);
}

float EquilibriumDistribution(int x, int y, int i) {
  PVector u = Velocity(x, y);
  PVector ci = Velocities[i];
  float d = Density(x, y);


  float uc = constrain(PVector.dot(u, ci), -maxVelocitySq, maxVelocitySq);
  float uu = constrain(PVector.dot(u, u), -maxVelocitySq, maxVelocitySq);

  //float uc = /*constrain(*/PVector.dot(u, ci)/*, -cs + epsilon, cs - epsilon)*/;
  //float uu = /*constrain(*/PVector.dot(u, u)/*, -cs + epsilon, cs - epsilon)*/;
  return t[i] * d * ((1.0) + (uc/ csSq) + (1.0/2.0) * pow(uc/csSq, 2) - (uu / (2*csSq)) );
}

float MomentumTensorMag(int x, int y) {
  float sum = 0;
  for (int i = 0; i < numWeights; i++) {
    PVector v = Velocities[i];
    sum += (v.x * v.y) * (wind[x][y][i] - EquilibriumDistribution(x, y, i));
  }
  return sum;
}

float StressTensorMag(int x, int y) {
  float enumerator = -relax + sqrt(relaxSq + 18.0 * lambdaSq * CsmagoSq * abs(MomentumTensorMag(x, y)));
  float denominator = 6.0 * lambdaSq * CsmagoSq;
  //println(CsmagoSq*lambdaSq*(enumerator/denominator));
  return enumerator / denominator;
}

float CorrectedRelaxationTime(int x, int y) {
  return relax + 3.0 * CsmagoSq * lambdaSq * abs(StressTensorMag(x, y));
}
