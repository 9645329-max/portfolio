// Torr Hardin | 17 Sept 2025 | SpaceGame
Spaceship s1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowerUp> powups = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
Timer rockTimer, puTimer, levelTimer;
int score, rocksPassed, level;
boolean play;
PImage go1, bg1;

void setup () {
  size(800, 800);
  //fullScreen();
  background(20);
  go1 = loadImage("GameOverScreen.png");
  bg1 = loadImage("HampsterScreen.png");
  s1 = new Spaceship();

  puTimer = new Timer(2000);
  levelTimer = new Timer(30000);
  levelTimer.start();
  puTimer.start();
  rockTimer = new Timer(500);
  rockTimer.start();
  rocksPassed = 0;
  score = 0;
  play = false;
  level = 1;
}



void draw() {
  if (!play) {
    startScreen ();
  } else {
    background(20);
     // Adding Stars
    stars.add(new Star());
     // Display and Remove Stars
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        println("Stars: " + stars.size()); 
        stars.remove(star);
      }
      
      //i--;
      println("Stars: " + stars.size());
    }
    // Check Levels
    if (level == 1) {
      // Decrease rockTimer
    }

    //Distribution of PowerUps on a Timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }

    // Display and Move Powerups
    for (int i = 0; i<powups.size(); i++) {
      PowerUp pu = powups.get(i);
      pu.display();
      pu.move();

      if (pu.intersect(s1)) {
        // Remove Powerup
        // Based on type, benefit player
        if (pu.type == 'H') {
          s1.health+=100;
          // Turret Increase
        } else if (pu.type == 'T') {
          s1.turretCount+=1;
          if (s1.turretCount>5) {
            s1.turretCount = 5;
          }
          // Ammo Increase
        } else if (pu.type == 'A') {
          s1.laserCount+=100;
        }
      }
      powups.remove(pu);
    }
   
    //Distribution of Rocks on a Timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }

    //Display and Moves of All Rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();

      if (s1.intersect(rock)) {
        rocks.remove(rock);
        score+=rock.diam;
        s1.health-=10;
      }

      if (rock.reachedBottom()) {
        rocksPassed = rocksPassed + 1;
        rocks.remove(rock);
        i--;
      }
      println("Rocks: " + rocks.size());
    }

    //Display and remove unwanted lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {
          // rock size reduces
          //check rock size is less than 5
          // remove rock
          //remove laser
          // score is increased by rock diameter
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
        i--;
        continue;
      }
    }
    for (int j = 0; j<rocks.size(); j++) {
      Rock r = rocks.get(j);
      if (s1.intersect(r)) {
        // 1. Get rid of rock
        // 2. Get rid of laser
        rocks.remove(r);
        // 3. Update Score +100
        score+=100;
        // 4. Rock Health Based on Size
        r.diam-= 50;
        //5. laser does less hp if rock is bigger
        if (r.diam<10) {
          rocks.remove(r);
        }
      }
      println("Lasers: " + lasers.size());
    }




    s1.display();
    s1.move(mouseX, mouseY);
    infoPanel();

    if (s1.health<1) {
      gameOver();
    }
  }
}




void mousePressed() {
  if (!play) {
    play = true;
    return;
  }
  lasers.add(new Laser(s1.x, s1.y));
  s1.laserCount--;
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  noStroke();
  rect(width/2, height-25, width, 50);
  fill(255);
  textSize(25);
  text("Score: " + score, 55, width-20);
  text("Ammo: " + s1.laserCount, 625, width-20);
  text("Health: " + s1.health, 225, width-20);
  text("Rocks Passed: " + rocksPassed, 400, width-20);
}

void startScreen() {
  image(bg1, 0, 0);
  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  image(go1, 0, 0);
  if (s1.health>1) {
    noLoop();
  }
}
