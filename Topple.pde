boolean TryTopple(int i, int j) {
  if (j <= 0)
    return false;
  boolean leftIsFree = i > 0 && IsFree(i-1, j);
  boolean rightIsFree = i < gridSize - 1 && IsFree(i+1, j);
  if (!(leftIsFree || rightIsFree))
    return false;

  float toppleProbability = map(Velocity(i, j-1).magSq(), 0, toppleVelocitySq, 0, 1);
  if (random(0, 1) > toppleProbability)
    Topple(i, j, leftIsFree, rightIsFree);
  else
    snowBuffer[i][j] += snow[i][j];
  return true;
}

void Topple(int i, int j, boolean leftIsFree, boolean rightIsFree) {
  float neighborCount = (leftIsFree ? 1 : 0) + (rightIsFree ? 1 : 0);
  int erodeAmount = (int) (toppleRatio * snow[i][j]);
  snowBuffer[i][j] += snow[i][j] - erodeAmount;

  int erodeLeft = (int) (erodeAmount / neighborCount);
  int erodeRight = erodeAmount - erodeLeft;

  if (i > 0)
    snowBuffer[i - 1][j] += erodeLeft;
  if (i < gridSize - 1)
    snowBuffer[i + 1][j] += erodeRight;
}
