import processing.sound.*; 

Playar playar;
Room currentRoom;
Room1 room1;
Room2 room2;
Room3 room3;

PImage[] marioFrames = new PImage[5];
PImage[] marioFramesBack = new PImage[5];
PImage keyImg, enemyImg1, enemyImg2, winImg, loseImg, pauseImg, startImg, backgroundImg, doorImg;

boolean gamePaused = false;
boolean gameWon = false;
boolean gameLost = false;
boolean gamestart = false;

// --- SOUND VARIABLES ---
SoundFile startSound;
SoundFile chaseSound;
SoundFile screamSound;
SoundFile keySound;

boolean chasePlaying = false;

void setup() {
  fullScreen();

  for (int i = 0; i < 5; i++) {
    marioFrames[i] = loadImage("mario" + (i+1) + ".png");
    marioFramesBack[i] = loadImage("backmario" + (i+1) + ".png");
  }

  keyImg = loadImage("key.png");
  enemyImg1 = loadImage("maltigi better.png");  // Room1 enemy image
  enemyImg2 = loadImage("Urio.png");            // Room2 enemy image
  winImg = loadImage("AlexWinga.png");
  loseImg = loadImage("WEGALOSE-1-1.png");
  pauseImg = loadImage("PauseScreen-1-1.png");
  startImg = loadImage("start.png");
  backgroundImg = loadImage("background.png");
  doorImg = loadImage("door.png");

  // --- LOAD SOUNDS ---
  startSound = new SoundFile(this,"Maltigi-Intro.wav");
  chaseSound = new SoundFile(this, "MaltigiChaseTheme.wav");
  screamSound = new SoundFile(this, "Voicy_Maltigi Scream.mp3");
  keySound = new SoundFile(this, "MaltigiGetKey.mp3");

  playar = new Playar(this, 800, 700, marioFrames, marioFramesBack);

  room1 = new Room1(this, backgroundImg, doorImg, enemyImg1, keyImg);
  room2 = new Room2(this, loadImage("Library-1.png.png"), doorImg, enemyImg2, keyImg);
  room3 = new Room3(this, loadImage("Foyer.png"), doorImg, null, keyImg); // Room3 has no enemy

  currentRoom = room1;
}

void draw() {
  if (!gamestart) { 
    image(startImg, 0, 0, width, height);
    if (!startSound.isPlaying()) startSound.play();
    return; 
  }

  if (gamePaused) { 
    image(pauseImg, 0, 0, width, height);
    return; 
  }

  if (gameWon) { 
    image(winImg, 0, 0, width, height); 
    return; 
  }

  if (gameLost) { 
    image(loseImg, 0, 0, width, height); 
    if (!screamSound.isPlaying()) screamSound.play();
    return; 
  }

  currentRoom.run(playar);

  // --- ENEMY COLLISION & CHASE SOUND ---
  boolean playerCaught = false;

  if (currentRoom instanceof Room1) {
    Room1 r = (Room1) currentRoom;
    if (r.enemy != null && r.enemy.checkCollision(playar)) playerCaught = true;
    else if (r.enemy != null && dist(playar.x, playar.y, r.enemy.x, r.enemy.y) < 300) {
      if (!chaseSound.isPlaying()) chaseSound.loop();  
      chasePlaying = true;
    } else {
      if (chasePlaying) { chaseSound.stop(); chasePlaying = false; }
    }
  }

  else if (currentRoom instanceof Room2) {
    Room2 r = (Room2) currentRoom;
    if (r.enemy != null && r.enemy.checkCollision(playar)) playerCaught = true;
    else if (r.enemy != null && dist(playar.x, playar.y, r.enemy.x, r.enemy.y) < 300) {
      if (!chaseSound.isPlaying()) chaseSound.loop();
      chasePlaying = true;
    } else {
      if (chasePlaying) { chaseSound.stop(); chasePlaying = false; }
    }
  }

  if (playerCaught) {
    println("PLAYER HIT BY ENEMY! GAME OVER!");
    gameLost = true;
    chaseSound.stop();
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') gamePaused = !gamePaused;

  if (!gamePaused) {
    if (key == 'a' || key == 'A') playar.movingLeft = true;
    if (key == 'd' || key == 'D') playar.movingRight = true;
    if (key == 'w' || key == 'W') playar.movingUp = true;
    if (key == 's' || key == 'S') playar.movingDown = true;

    if (key == 'e' || key == 'E') {
      if (currentRoom == room1 && room1.nearDoor && room1.key.isCollected) {
        currentRoom = room2;
        playar.x = 300; playar.y = 300;
        if (keySound.isPlaying()) keySound.stop();
      } 
      else if (currentRoom == room2 && room2.nearDoor && room2.key.isCollected) {
        currentRoom = room3;
        playar.x = 300; playar.y = 300;
        if (keySound.isPlaying()) keySound.stop();
      } 
      else if (currentRoom == room3 && room3.nearDoor && room3.key.isCollected) {
        gameWon = true;
      }
    }
  }
}

void keyReleased() {
  if (!gamePaused) {
    if (key == 'a' || key == 'A') playar.movingLeft = false;
    if (key == 'd' || key == 'D') playar.movingRight = false;
    if (key == 'w' || key == 'W') playar.movingUp = false;
    if (key == 's' || key == 'S') playar.movingDown = false;
  }
}

void mousePressed() {
  if (!gamestart) {
    gamestart = true;
    if (startSound.isPlaying()) startSound.stop();
  }
}

void playKeySound() {
  if (!keySound.isPlaying()) keySound.play();
}
