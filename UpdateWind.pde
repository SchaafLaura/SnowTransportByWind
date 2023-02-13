void AddWind() {
  for (int i = 0; i < gridSizeY - 5; i++)
    for (int k = 0; k < numWeights; k++)
      if (IsFree(1, i))
        wind[1][i][k] *= 1.13;
}

void StepWind() {
  buffer = new float[gridSizeX][gridSizeY][numWeights];
  for (int i = 0; i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      if ((boundary[i][j] || (snow[i][j] > freezeThreshold)) && TrapWind(i, j))
        continue;
      StreamWind(i, j, (1.0 / CorrectedRelaxationTime(i, j)));
    }
  }
  HandleWindBoundaryConditions();
  CopyWindFromBuffer();
}

void StreamWind(int i, int j, float correctedTimeInverse) {
  for (int k = 0; k < numWeights; k++) {
    int x = i + (int)Velocities[k].x;
    int y = j + (int)Velocities[k].y;

    x = x < 0 ? gridSizeX - 1 : x;
    x = x == gridSizeX ? 0 : x;
    y = y < 0 ? gridSizeY - 1 : y;
    y = y == gridSizeY ? 0 : y;

    if (!boundary[x][y] && !(snow[x][y] > freezeThreshold)) {
      buffer[x][y][k] = wind[i][j][k] + correctedTimeInverse * (EquilibriumDistribution(i, j, k) - wind[i][j][k]);
    } else {
      buffer[i][j][Opposite(k)] = wind[i][j][k] + correctedTimeInverse * (EquilibriumDistribution(i, j, k) - wind[i][j][k]);
    }
  }
}

void HandleWindBoundaryConditions() {
  for (int i = 0; i < gridSizeY; i++)
    for (int k = 0; k < numWeights; k++)
      buffer[gridSizeX-1][i][k] = wind[gridSizeX - 2][i][k];
}

boolean TrapWind(int i, int j) {
  for (int k = 0; k < numWeights; k++)
    buffer[i][j][0] += wind[i][j][k];
  return true;
}

void CopyWindFromBuffer() {
  for (int i = 0; i < gridSizeX; i++)
    for (int j = 0; j < gridSizeY; j++)
      for (int k = 0; k < numWeights; k++)
        wind[i][j][k] = buffer[i][j][k];
}
