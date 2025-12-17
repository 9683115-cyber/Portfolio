// Dave Martinez Valencia, Kai Li Cantwell
class Enemy {
  PApplet parent;
  PImage img;


  float x, y, w, h;

  float speed;           
  float range;           
  float dirX, dirY;
  float chaseMultiplier = 3.0f;
  float wanderMultiplier = 4.0f; 

 
  float hitboxXOffset = 7;
  float hitboxYOffset = 5;
  float hitboxWidth = 40;
  float hitboxHeight = 60;

  float leftLimit = 550;
  float rightLimit = 1370;
  float topLimit = 140;
  float bottomLimit = 1100;

  
  int wanderTimer = 0;
  int wanderDelay = 60;

  Enemy(PApplet p, float startX, float startY, float w_, float h_, float spd, float rng, PImage i) {
    parent = p;
    x = startX;
    y = startY;
    w = w_;
    h = h_;
    speed = spd;
    range = rng;
    img = i;

    dirX = parent.random(-1, 1);
    dirY = parent.random(-1, 1);
  }

  void update(Playar playar, ArrayList<Obstacle> obstacles) {
    float moveX = 0, moveY = 0;

    float distance = parent.dist(
      x + w/2, y + h/2,
      playar.x + playar.width/2,
      playar.y + playar.height/2
    );

   
    if (distance < range) {
      float angle = parent.atan2(
        playar.y + playar.height/2 - (y + h/2),
        playar.x + playar.width/2 - (x + w/2)
      );
      moveX = parent.cos(angle) * speed * chaseMultiplier;
      moveY = parent.sin(angle) * speed * chaseMultiplier;
    } 

    else {
      wanderTimer++;
      if (wanderTimer >= wanderDelay) {
        dirX = parent.random(-1, 1);
        dirY = parent.random(-1, 1);
        wanderTimer = 0;
      }
      moveX = dirX * speed * wanderMultiplier;
      moveY = dirY * speed * wanderMultiplier;
    }

    float oldX = x;
    float oldY = y;

   
    x += moveX;
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        x = oldX;
        dirX *= -1;
        break;
      }
    }


    y += moveY;
    for (Obstacle o : obstacles) {
      if (collidesWith(o.x, o.y, o.w, o.h)) {
        y = oldY;
        dirY *= -1;
        break;
      }
    }


    if (x <= leftLimit) { x = leftLimit; dirX *= -1; }
    if (x + w >= rightLimit) { x = rightLimit - w; dirX *= -1; }
    if (y <= topLimit) { y = topLimit; dirY *= -1; }
    if (y + h >= bottomLimit) { y = bottomLimit - h; dirY *= -1; }
  }

  void display() {
    parent.image(img, x, y, w, h);
  }

  boolean collidesWith(float ox, float oy, float ow, float oh) {
    float hx = x + hitboxXOffset;
    float hy = y + hitboxYOffset;
    return !(hx + hitboxWidth <= ox || hx >= ox + ow || hy + hitboxHeight <= oy || hy >= oy + oh);
  }

  boolean checkCollision(Playar p) {
    return !(p.x + p.width < x || p.x > x + w || p.y + p.height < y || p.y > y + h);
  }
}
