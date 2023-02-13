float scale;
final int gridSizeX = 160;
final int gridSizeY = 90;

void setup() {
  size(1600, 900);
  noStroke();
  scale = (float) min(width, height) / (float) min(gridSizeX, gridSizeY);
  SetupBoundary();
  SetupWind();
  SetupSnow();
}

boolean record = false;
boolean makeItSnowy = false;
boolean makeItWindy = false;

int screen = 0;
void draw() {


  if (makeItSnowy)
    AddSnow();
  if (makeItWindy)
    AddWind();


  StepWind();
  StepSnow();
  if (frameCount < 1) {
    SmoothWind();
  }


  background(0);

  switch(screen) {
  case 0:
    ShowSnow();
    break;
  case 1:
    ShowVelocity();
    break;
  case 2:
    ShowDirectionalVelocity();
    break;
  }


  if (record)
    saveFrame("#####.png");
}

void ShowDirectionalVelocity() {
  noStroke();
  for (int i = 0; i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {


      PVector velocity = Velocity(i, j);
      float vLeft = - velocity.x + 0.15;
      float vRight = velocity.x;
      float vUp = -velocity.y;
      float vDown = velocity.y;

      float r = map(vLeft, 0, cs/5.0, 0, 255);
      float b = map(vDown, 0, cs/5.0, 0, 255);
      float g = map(vUp, 0, cs/5.0, 0, 255);
      fill(r, g, b);


      if (boundary[i][j])
        fill(20);
      square(i * scale, j * scale, scale);
    }
  }
}

void ShowSnow() {
  for (int i = 0; i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      int snowD = snow[i][j];
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

void ShowVelocity() {
  float recordv = 0;
  for (int i = 0; i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      float vv = abs(Velocity(i, j).mag());
      float f = map(vv, 0, maxVelocitySq * 2.0, 0, 255);
      f = f == 0 ? 0 : f + 25;
      fill(f);
      if (boundary[i][j])
        fill(20);
      square(i * scale, j * scale, scale);
      
      if(vv > recordv)
        recordv = vv;
      
    }
  }
  
  if(recordv > maxVelocitySq * 3)
    SetupWind();
  
  
}
