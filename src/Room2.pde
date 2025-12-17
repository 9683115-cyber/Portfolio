class Room2 extends Room {
  Enemy2 enemy;
  Task task;
  Key key;

  PImage doorImg;
  float doorX = 1330, doorY = 910;
  float doorW = 480, doorH = 210;
  boolean nearDoor = false;

  Room2(PApplet p, PImage bgImg, PImage doorImg_, PImage enemyImg, PImage keyImg) {
    super(p, bgImg);
    doorImg = doorImg_;

    key = new Key(parent, 250, 350, keyImg);
    task = new Task(parent, 600, 500, "Escape Biblioteca");
    enemy = new Enemy2(parent, 900, 200, 64, 96, 2, 200, enemyImg);
  }

  @Override
  void run(Playar player) {

    player.setLimits(160, 1730, 20, 950);

    obstacles.clear();
    obstacles.add(new Obstacle(1450, 530, 270, 220));
    obstacles.add(new Obstacle(1165, 530, 270, 220));
    obstacles.add(new Obstacle(870, 530, 270, 220));
    obstacles.add(new Obstacle(1450, 22, 270, 220));
    obstacles.add(new Obstacle(1170, 22, 270, 220));
    obstacles.add(new Obstacle(200, 22, 270, 220));
    obstacles.add(new Obstacle(185, 400, 380, 400));

    parent.image(backgroundImg, 0, 0, parent.width, parent.height);
    parent.image(doorImg, doorX, doorY, doorW, doorH);

    nearDoor = playerTouchingDoor(player, doorX, doorY, doorW, doorH);

    if (nearDoor && key.isCollected) {
      parent.textAlign(CENTER);
      parent.fill(255);
      parent.textSize(32);
      parent.text("Press E to Enter", doorX + doorW/2, doorY - 20);
    }

    for (Obstacle o : obstacles) o.display();
    player.update(obstacles);
    player.display();

    if (key != null) { key.display(); key.checkCollision(player); }
    if (task != null) task.checkInteraction(player);

    if (enemy != null) {
      enemy.update(player, obstacles);
      enemy.display();
    }
  }

  @Override
  boolean isComplete() {
    return key.isCollected && task.complete;
  }
}
