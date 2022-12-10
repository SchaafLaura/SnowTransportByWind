float[][][] wind;
int[][] snow;
int[][] snowBuffer;
float[][][] buffer;
boolean[][] boundary;

void SetupBoundary() {
  boundary = new boolean[gridSize][gridSize];
  for (int i = 0; i < gridSize; i++) {
    boundary[i][gridSize - 1] = true;
    boundary[0][i] = true;
  }
}

void SetupSnow() {
  snow = new int[gridSize][gridSize];
}

float initialMaxwindPerDirection = 1;
float initialMaxDensity = initialMaxwindPerDirection * 9;
void SetupWind() {
  wind = new float[gridSize][gridSize][9];
  buffer = new float[gridSize][gridSize][9];
  for (int i = 0; i < gridSize; i++)
    for (int j = 0; j < gridSize; j++)
      for (int k = 0; k < 9; k++)
        wind[i][j][k] = random(initialMaxwindPerDirection/10, initialMaxwindPerDirection);
}
