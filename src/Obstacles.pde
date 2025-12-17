class Obstacle {
  float x, y, w, h;
  Obstacle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void display() {
    noFill();
    noStroke();
    rect(x, y, w, h);
  }
}
