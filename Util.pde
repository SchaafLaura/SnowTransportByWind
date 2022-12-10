boolean IsFree(int i, int j) {
  return !IsFrozen(i, j) && !boundary[i][j];
}

boolean IsFrozen(int i, int j) {
  return snow[i][j] >= freezeThreshold;
}

boolean IsSupportedBelow(int i, int j) {
  boolean belowIsSolid = j < gridSize - 1 && !IsFree(i, j+1);
  boolean belowLeftIsSolid = i > 0 && !IsFree(i-1, j+1);
  boolean belowRightIsSolid = i < gridSize - 1 && !IsFree(i+1, j+1);
  return belowIsSolid && belowLeftIsSolid && belowRightIsSolid;
}

boolean IsSupportedSides(int i, int j) {
  boolean leftIsSolid = i > 0 && !IsFree(i-1, j);
  boolean rightIsSolid = i < gridSize - 1 && !IsFree(i+1, j);
  return leftIsSolid && rightIsSolid;
}

boolean IsSupportedAbove(int i, int j) {
  boolean aboveIsSolid = j > 0 && !IsFree(i, j-1);
  boolean aboveLeftIsSolid = j > 0 && i > 0 && !IsFree(i - 1, j - 1);
  boolean aboveRightIsSolid = j > 0 && i < gridSize - 1 && !IsFree(i + 1, j - 1);
  return aboveIsSolid && (aboveLeftIsSolid || aboveRightIsSolid);
}

int Opposite(int k) {
  switch(k) {
  case 0:
    return 0;
  case 1:
    return 3;
  case 2:
    return 8;
  case 3:
    return 1;
  case 4:
    return 6;
  case 5:
    return 7;
  case 6:
    return 4;
  case 7:
    return 5;
  case 8:
    return 2;
  }
  return -1;
}
