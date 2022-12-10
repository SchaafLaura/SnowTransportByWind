float scale;
void setup() {
  size(1000, 1000);
  noStroke();
  scale = (float) width / (float) gridSize;
  SetupBoundary();
  SetupWind();
  SetupSnow();
}

boolean record = false;
boolean makeItSnowy = false;
boolean makeItWindy = true;
void draw() {
  if (makeItSnowy)
    AddSnow();
  if (makeItWindy)
    AddWind();
    
    
  StepWind();
  StepSnow();

  background(0);
  DrawGrid();
  if (record)
    saveFrame("#####.png");
}

void DrawGrid() {
  noStroke();
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int snowD = snow[i][j];
      //float vv = Velocity(i, j).magSq();
      //float f = map(vv, 0, v, 0, 255);
      float f = map(snowD, 0, freezeThreshold, 0, 230);
      f = f == 0 ? 0 : f + 25;
      fill(f);
      if (snowD > freezeThreshold)
        fill(230, 230, 255);
      if (boundary[i][j])
        fill(20);
      square(i * scale, j * scale, scale);
    }
  }
}
