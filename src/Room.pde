class Room {
  PApplet parent;
  PImage backgroundImg;
  ArrayList<Obstacle> obstacles;

  Room(PApplet p, PImage bg) {
    parent = p;
    backgroundImg = bg;
    obstacles = new ArrayList<Obstacle>();
  }

  void run(Playar player) {
    parent.image(backgroundImg, 0, 0, parent.width, parent.height);

    for (Obstacle o : obstacles) o.display();
    player.update(obstacles);
    player.display();
  }

  boolean playerTouchingDoor(Playar p, float dx, float dy, float dw, float dh) {
    return p.x + p.width > dx &&
           p.x < dx + dw &&
           p.y + p.height > dy &&
           p.y < dy + dh;
  }

  boolean isComplete() {
    return true;
  }
}
