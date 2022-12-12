boolean TryWindErode(int i, int j) {
  boolean aboveIsFrozen = j > 0 && IsFrozen(i, j-1);
  boolean windIsFast = j > 0 && Velocity(i, j-1).magSq() > erosionThresholdVelocitySq;

  if (!aboveIsFrozen && windIsFast) {
    Erode(i, j);
    return true;
  } else {
    snowBuffer[i][j] += snow[i][j];
  }

  return true;
}

void Erode(int i, int j) {
  if (random(0, 1) < erosionProbability) {
    int erodeAmount = (int) (erodeRatio * snow[i][j]);
    snowBuffer[i][j-1] += erodeAmount;
    snowBuffer[i][j] += snow[i][j] - erodeAmount;
  } else {
    snowBuffer[i][j] += snow[i][j];
  }
}
