  class Laser {
  //Member Variables
  int x, y, w, h, speed;
  PImage l1;
 

  // Constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    w = 80;
    h = 80;
    speed = 10;
    l1 = loadImage("Missile.png");
    }
  


  // Member Methods
  void display() {
    l1.resize(w,h);
    image(l1, x, y);
    imageMode(CENTER);
  }


  void move() {
    y = y - speed;
  }

  boolean reachedTop() {
    if (y<0-10) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Rock r) {
    float d = dist(x,y,r.x,r.y);
    if(d<10) {
      return true;
    } else {
      return false;
    }
  }
}
