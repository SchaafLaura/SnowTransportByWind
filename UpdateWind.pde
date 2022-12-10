void AddWind() {
  for (int i = (int) (gridSize/(2.5)); i < gridSize; i++)
    for (int k = 0; k < 9; k++)
      wind[(int)random(1, 3)][i][k] *= 1.1;
}

void StepWind() {
  buffer = new float[gridSize][gridSize][9];
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if ((boundary[i][j] || (snow[i][j] > freezeThreshold)) && TrapWind(i, j))
        continue;
      StreamWind(i, j, (1.0 / CorrectedRelaxationTime(i, j)));
    }
  }
  HandleWindBoundaryConditions();
  CopyWindFromBuffer();
}

void StreamWind(int i, int j, float correctedTimeInverse) {
  for (int k = 0; k < 9; k++) {
    int x = i + (int)Velocities[k].x;
    int y = j + (int)Velocities[k].y;

    x = x < 0 ? gridSize - 1 : x;
    x = x == gridSize ? 0 : x;
    y = y < 0 ? gridSize - 1 : y;
    y = y == gridSize ? 0 : y;

    if (!boundary[x][y] && !(snow[x][y] > freezeThreshold)) {
      buffer[x][y][k] = wind[i][j][k] + correctedTimeInverse * (EquilibriumDistribution(i, j, k) - wind[i][j][k]);
    } else {
      buffer[i][j][Opposite(k)] = wind[i][j][k] + correctedTimeInverse * (EquilibriumDistribution(i, j, k) - wind[i][j][k]);
    }
  }
}

void HandleWindBoundaryConditions() {
  for (int i = 0; i < gridSize; i++)
    for (int k = 0; k < 9; k++)
      buffer[gridSize-1][i][k] = wind[gridSize - 2][i][k];
}

boolean TrapWind(int i, int j) {
  for (int k = 0; k < 9; k++)
    buffer[i][j][0] += wind[i][j][k];
  return true;
}

void CopyWindFromBuffer() {
  for (int i = 0; i < gridSize; i++)
    for (int j = 0; j < gridSize; j++)
      for (int k = 0; k < 9; k++)
        wind[i][j][k] = buffer[i][j][k];
}
