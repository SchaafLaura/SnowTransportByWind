void AddSnow() {
  for (int i = 0; i < gridSize; i++)
    if (random(0, 1) > 0.99)
      snow[i][(int)random(1, 3)] += snowSpawnAmount;
}

void StepSnow() {
  snowBuffer = new int[gridSize][gridSize];
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (boundary[i][j])
        continue;
      boolean isFrozen = IsFrozen(i, j);
      if (isFrozen && IsSupportedBelow(i, j) && TryWindErode(i, j))
        continue;
      if (isFrozen && !IsSupportedBelow(i, j) && !(IsSupportedSides(i, j) || IsSupportedAbove(i, j)) && TryFall(i, j))
        continue;
      if (isFrozen && TryTopple(i, j))
        continue;
      StreamSnow(i, j);
    }
  }
  HandleSnowBoundaryConditions();
  CopySnowFromBuffer();
}

void CopySnowFromBuffer() {
  for (int i = 0; i < gridSize; i++)
    for (int j = 0; j < gridSize; j++)
      snow[i][j] = snowBuffer[i][j];
}

void HandleSnowBoundaryConditions() {
  for (int i = 0; i < gridSize; i++)
    snowBuffer[gridSize - 1][i] = 0;
}

void StreamSnow(int i, int j) {
  PVector diff = PVector.sub(Velocity(i, j), gravity);
  float px = max(0, (PVector.dot(Velocities[1], diff)) / csSq);
  float p_x = max(0, (PVector.dot(Velocities[3], diff)) / csSq);
  float py = max(0, (PVector.dot(Velocities[5], diff)) / csSq);
  float p_y = max(0, (PVector.dot(Velocities[7], diff)) / csSq);
  for (int n = 0; n < snow[i][j]; n++)
    MoveSnowParticleToNewLocation(i, j, px, p_x, py, p_y);
}

void MoveSnowParticleToNewLocation(int i, int j, float px, float p_x, float py, float p_y) {
  int x = i + MotionByProbability(px, p_x);
  int y = j + MotionByProbability(py, p_y);
  x = constrain(x, 0, gridSize - 1);
  y = constrain(y, 0, gridSize - 1);

  if (IsFree(x, y))
    snowBuffer[x][y] += 1;
  else
    snowBuffer[i][j] += 1;
}

int MotionByProbability(float pPos, float pNeg) {
  int motion = 0;
  float q = random(0, 1);
  if (q < pPos)
    motion = 1;
  else if (q < pNeg)
    motion = -1;
  return motion;
}
