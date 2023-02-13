float[][][] wind;
int[][] snow;
int[][] snowBuffer;
float[][][] buffer;
boolean[][] boundary;

void SetupBoundary() {
  boundary = new boolean[gridSizeX][gridSizeY];
  for (int i = 0; i < gridSizeX; i++)
    boundary[i][gridSizeY - 1] = true;
  for (int i = 0; i < gridSizeY; i++)
    boundary[0][i] = true;
}

void SetupSnow() {
  snow = new int[gridSizeX][gridSizeY];
}

float initialMaxwindPerDirection = 1;
float initialMaxDensity = initialMaxwindPerDirection * numWeights;
void SetupWind() {
  wind = new float[gridSizeX][gridSizeY][numWeights];
  buffer = new float[gridSizeX][gridSizeY][numWeights];
  for (int i = 0; i < gridSizeX; i++)
    for (int j = 0; j < gridSizeY; j++)
      for (int k = 0; k < numWeights; k++)
        wind[i][j][k] = random(initialMaxwindPerDirection/10, initialMaxwindPerDirection);

  SmoothWind();
  SmoothWind();
  SmoothWind();
  SmoothWind();
  SmoothWind();
  SmoothWind();
  SmoothWind();
  SmoothWind();
}
