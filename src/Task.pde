// Rusty Spendlove
class Task {
  PApplet parent;
  float x, y;
  String description;
  boolean complete = false;
  float size = 40;

  Task(PApplet p, float startX, float startY, String desc) {
    parent = p;
    x = startX;
    y = startY;
    description = desc;
  }

  void display() {
    parent.fill(complete ? color(100, 200, 100) : color(200, 100, 100));
    parent.ellipse(x, y, size, size);
    parent.fill(255);
    parent.textAlign(CENTER);
    parent.text(description, x, y - size);
  }

  void checkInteraction(Playar p) {
    float distance = parent.dist(x, y, p.x + p.width/2, p.y + p.height/2);
    if (distance < size/2 + max(p.width, p.height)/2) complete = true;
  }
}
