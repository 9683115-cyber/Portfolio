class Room1 extends Room {
  Enemy enemy;
  Task task;
  Key key;

  PImage doorImg;
  float doorX = 430, doorY = 491;
  float doorW = 190, doorH = 270;
  boolean nearDoor = false;

  Room1(PApplet p, PImage bgImg, PImage doorImg_, PImage enemyImg, PImage keyImg) {
    super(p, bgImg);
    doorImg = doorImg_;

    key = new Key(parent, 600, 200, keyImg);
    task = new Task(parent, 520, 580, "Find the Key");
    enemy = new Enemy(parent, 750, 200, 64, 96, 2, 200, enemyImg);

    obstacles.add(new Obstacle(882, 320, 255, 329));
    obstacles.add(new Obstacle(780, 350, 60, 60));
    obstacles.add(new Obstacle(788, 569, 55, 55));
    obstacles.add(new Obstacle(1170, 426, 55, 55));
    obstacles.add(new Obstacle(1170, 565, 55, 55));
    obstacles.add(new Obstacle(1080, 835, 100, 165));
    obstacles.add(new Obstacle(950, 237, 400, 79));
  }

  @Override
  void run(Playar player) {
    player.setLimits(550, 1370, 140, 1100);

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
