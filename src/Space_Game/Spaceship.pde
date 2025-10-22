class Spaceship {
  //Member Variables
  int x, y, w, laserCount, turretCount, health;
  PImage ship;
  
  // Constructor
  Spaceship () {
    x = mouseX/2;
    y = mouseY/2;
    w = 100;
    laserCount = 100;
    turretCount = 1;
    health = 100;
    ship = loadImage("Hampstership.png");
  }

  // Member Methods
  void display() {
    imageMode(CENTER);
    image(ship,mouseX,mouseY);
    
  }


  void move(int x, int y) {
    this.x = x;
    this.y = y;
  }

  boolean fire() {
    if(laserCount>0) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock r) {
    float d = dist(x,y,r.x,r.y);
    if(d<50) {
      return true;
    } else {
      return false;
    }
  }
}
