
class Monster {
  float xPos;
  float yPos;



  int currentMonster;

  //Timer gameTimer;
  //Timer imageTimer;

  //boolean timerStarted = false;
  // how long to stay in this currentMonster

  int totalCurrentMonsterTime;
  // how long have we been in this currentMonster?

  int currentMonsterTime;
  //constructor

  PImage myFace;

  Monster(float x, float y, int img) {
    xPos = x;
    yPos = y;
    //start it empty

    myFace = monsters[img];

    currentMonster = 0;


    /*//initialize the timers
     
     gameTimer = new Timer(30);
     
     imageTimer = new Timer((int) random(1, 4));*/

    resetTimers();
  }

  void resetTimers() {
    // pick a random amount of time to stay in this currentMonster
    totalCurrentMonsterTime = int(random(50, 400));
    // reset our current counter
    currentMonsterTime = 0;
  }

  void update() {
    // increase amount of time in our current currentMonster
    currentMonsterTime++;
    // have we gone over our total currentMonster time?

    if (currentMonsterTime >= totalCurrentMonsterTime)
    {
      // switch!
      if (currentMonster == 0) {
        // currentMonster = (int) 1;
        currentMonster = floor ((int) random(1, 5));
        println("monster " + currentMonster);
      } else {
        currentMonster = 0;
      }
      // reset timers
      resetTimers();
    }
  }

  void display() {
    if (currentMonster !=0) {
      image(myFace, xPos, yPos);
    }else{
      image(monsters[0], xPos, yPos);
    }
    //"monster1.png", bottomLeft;
  }

  //hits
  void checkHit() {
    //generic
    // if (dist(mouseX, mouseY, xPos, yPos) < 70) { 
    if (currentMonster == 1 && hit1) { // COPY THIS 4 TIMES
      currentMonster = 1;
      score++;
    } else if (currentMonster == 2 && hit2) { // COPY THIS 4 TIMES
      currentMonster = 2;
      score++;
    } else if (currentMonster == 3 && hit3) { // COPY THIS 4 TIMES
      currentMonster = 3;
      score++;
    } else if (currentMonster == 4 && hit4) { // COPY THIS 4 TIMES
      currentMonster = 4;
      score++;
    }
    //}
  }
  //is evil
  //    else if (currentMonster == 3 || currentMonster == 4) {
  //      monsterGameOver();
  //    }
  //  }
  //}

  void monsterGameOver() {
    gameOver = true;
    //sample = new SoundFile(this, "Game_Over.mp3")
    ;
  }
}