boolean TryFall(int i, int j) {
  int fallAmount = (int) (fallRatio * snow[i][j]);
  snowBuffer[i][j+1] += fallAmount;
  snowBuffer[i][j] += snow[i][j] - fallAmount;
  return true;
}
