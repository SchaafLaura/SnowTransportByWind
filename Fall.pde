boolean TryFall(int i, int j) {
  if (j < gridSizeY - 1 && !IsFree(i, j+1))
    return false;

  int fallAmount = (int) (fallRatio * snow[i][j]);
  snowBuffer[i][j+1] += fallAmount;
  snowBuffer[i][j] += snow[i][j] - fallAmount;
  return true;
}
