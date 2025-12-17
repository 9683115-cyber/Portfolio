class Room3 extends Room {
 
  Task task;
  Key key;

  PImage doorImg;
  float doorX = 430, doorY = 491;
  float doorW = 190, doorH = 270;
  boolean nearDoor = false;

  Room3(PApplet p, PImage bgImg, PImage doorImg_, PImage enemyImg, PImage keyImg) {
    super(p, bgImg);
    doorImg = doorImg_;

    key = new Key(parent, 500, 300, keyImg);
    task = new Task(parent, 650, 600, "Solve the PI Room");


    obstacles.add(new Obstacle(300, 200, 300, 100));
    obstacles.add(new Obstacle(800, 450, 250, 120));
    obstacles.add(new Obstacle(1200, 250, 200, 200));
  }

  @Override
  void run(Playar player) {

    player.setLimits(200, 1650, 100, 1000);

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

    
  }

  @Override
  boolean isComplete() {
    return key.isCollected && task.complete;
  }
}
