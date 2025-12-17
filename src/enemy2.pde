// Dave Martinez Valencia
class Enemy2 extends Enemy {
  Enemy2(PApplet p, float startX, float startY, float w_, float h_, float spd, float rng, PImage i) {
    super(p, startX, startY, w_, h_, spd, rng, i);

   
    leftLimit = 500;
    rightLimit = 1400;
    topLimit = 100;
    bottomLimit = 900;
  }
}
