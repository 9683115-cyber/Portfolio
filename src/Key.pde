// Malcom Kyle
class Key {
  PApplet parent;
  float x, y;
  boolean isCollected = false;
  PImage img;
  float width = 32, height = 32;

  Key(PApplet p, float startX, float startY, PImage i) {
    parent = p;
    x = startX;
    y = startY;
    img = i;
  }

  void display() {
    if (!isCollected)
      parent.image(img, x, y, width, height);
  }

  void checkCollision(Playar p) {
    if (isCollected) return;
    float px = p.x + p.hitboxXOffset;
    float py = p.y + p.hitboxYOffset;
    if (!(px + p.hitboxWidth <= x || px >= x + width || py + p.hitboxHeight <= y || py >= y + height)) {
      isCollected = true;
      println("Key Collected!");
    }
  }
}
