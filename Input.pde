void keyPressed() {
  if (key == 'r')
    record = !record;

  if (key == 's')
    makeItSnowy = !makeItSnowy;

  if (key == 'w')
    makeItWindy = !makeItWindy;
}

void mouseDragged() {
  if (mouseX < 0 || mouseX > width - scale || mouseY < 0 || mouseY > height - scale)
    return;

  int x = (int) (mouseX / scale);
  int y = (int) (mouseY / scale);

  if (mouseButton == LEFT) {
    boundary[x][y] = true;
    if (x > 0)
      boundary[x-1][y] = true;
    if (y > 0)
      boundary[x][y-1] = true;
    if (x < gridSize - 1)
      boundary[x+1][y] = true;
    if (y < gridSize - 1)
      boundary[x][y+1] = true;
  }

  if (mouseButton == RIGHT)
    snow[x][y] += freezeThreshold *2;
}
