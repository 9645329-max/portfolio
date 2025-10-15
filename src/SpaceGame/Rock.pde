class Rock {
  //Member Variables
  int x, y, w, diam, speed;
  PImage r1;

  // Constructor
  Rock () {
    x = int(random(width));
    y = -100;
    diam = int(random(50, 100));
    speed = int(random(1, 5));
    if (random(10)>6.6) {
      r1 = loadImage("Meteorite.png");
    } else if (random(10)>5.0) {
      r1 = loadImage("Rat.png");
    } else {
      r1 = loadImage("Rat Cheese Rock.png");
    }
  }


  // Member Methods
  void display() {
    imageMode(CENTER);
    r1.resize(diam, diam);
    image(r1, x, y);
  }


  void move() {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
}
