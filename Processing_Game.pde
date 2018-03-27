import processing.serial.*;
import processing.sound.*;

//PART 1

//initializing variables

SoundFile sample;

//top row
Monster topRight;
Monster topLeft;

//bottom row
Monster bottomRight;
Monster bottomLeft;


float serialValue=0;

Timer timer;
boolean gameOver;
int score;
int timeLeft;

PFont f;

PImage[] hammer;

void setup() {

  size(550, 550);

  imageMode(CENTER);

  textAlign(CENTER);

  score = 0;

  //background loaded

  f = loadFont("test.vlw");

  fill(255);

  timer = new Timer(30);
  timer.startTimer();

  //PART 2

  hammer = new PImage[2];
  hammer[0] = loadImage("hammer.png");
  hammer[1] = loadImage("hammerdown.png");
  
  topRight = new Monster(90+25, 75);
  topLeft = new Monster(410+25, 75);    

  bottomRight = new Monster(90+25, 395);
  bottomLeft = new Monster(410+25, 395);
  
  sample = new SoundFile(this, "Background.mp3");  
   
}


void draw() {
  if (gameOver == false) {
    background(0);
    noCursor();

    //timeLeft = (30 - (millis()/1000));

    timeLeft = (int) (30 - timer.passedTime);

    topRight.display();
    topLeft.display();

    bottomRight.display();
    bottomLeft.display();

    topRight.update();
    topLeft.update();

    bottomRight.update();
    bottomLeft.update();

    displayTimeScore();

    if (mousePressed) {
      image(hammer[1], mouseX, mouseY);
    } else {
      image(hammer[0], mouseX, mouseY);
    }

    if (timer.isFinished()) {
      bottomRight.monsterGameOver();
    }
  } else {
    //gameOver is true
    background(0);
    cursor();
    textFont(f, 50);
    text("Game Over\nScore = " + score, width/2, height/2 - 50);

    //draw replay button
    rectMode(CENTER);
    fill(255);
    rect(width/2, height-150, 150, 50);
    fill(0);
    textFont(f, 30);
    text("replay", width/2, height-140);
    fill(255);

    //if click on replay
    if (mouseX > (width/2 - 75) &&  mouseX < (width/2 + 75) && mouseY < height-150 + 25 && mouseY > height-150 - 25) {
      fill(0);
      rect(width/2, height-150, 150, 50);
      fill(255);
      textFont(f, 30);
      text("replay", width/2, height-140);

      if (mousePressed) {
        reset();
      }
    }
    //reset
  }
}

void mousePressed() {
  topRight.checkHit();
  topLeft.checkHit();

  bottomRight.checkHit();
  bottomLeft.checkHit();
}



void displayTimeScore() {
  textFont(f, 30);
  text("Time: " + timeLeft + " Score: " + score + "\nGoal: Don't Miss A Monster", width/2, height - 50);
}

void reset() {
  score = 0;
  timer.totalTime = 30;
  timer.startTimer();

  topRight.currentMonster = 0;
  topLeft.currentMonster = 0;

  bottomRight.currentMonster = 0;
  bottomLeft.currentMonster = 0;

  gameOver = false;
}

class Monster {
  float xPos;
  float yPos;

  PImage[] monsters;

  int currentMonster;

  //Timer gameTimer;
  //Timer imageTimer;

  //boolean timerStarted = false;
  // how long to stay in this currentMonster

  int totalCurrentMonsterTime;
  // how long have we been in this currentMonster?

  int currentMonsterTime;
  //constructor

  Monster(float x, float y) {
    xPos = x;
    yPos = y;
    //start it empty

    currentMonster = 0;
    
    //load the images
    monsters = new PImage[4];

    for (int i = 0; i < monsters.length; i++) {
      monsters[i] = loadImage("monster" + i + ".png");
    }

    /*//initialize the timers
     
     gameTimer = new Timer(30);
     
     imageTimer = new Timer((int) random(1, 4));*/

    resetTimers();
  }

  void resetTimers()
  {
    // pick a random amount of time to stay in this currentMonster
    totalCurrentMonsterTime = int(random(50, 600));

    // reset our current counter
    currentMonsterTime = 0;
  }

  void update()
  {
    // increase amount of time in our current currentMonster
    currentMonsterTime++;
    // have we gone over our total currentMonster time?

    if (currentMonsterTime >= totalCurrentMonsterTime)
    {
      // switch!
      if (currentMonster == 0) {
        currentMonster = (int) random(0, 4);
      } else {
        currentMonster = 0;
      }
      // reset timers
      resetTimers();
    }
  }

  void display() {
    image(monsters[currentMonster], xPos, yPos);
  }

  //hits
  void checkHit() {
    //generic
    if (dist(mouseX, mouseY, xPos, yPos) < 70) { 
      if (currentMonster == 1 && serialValue == 1) { // COPY THIS 4 TIMES
        currentMonster = 0;
        score++; 
        sample = new SoundFile(this, "Monster_Squish.mp3"); }
      else if (currentMonster == 2 && serialValue == 2) { // COPY THIS 4 TIMES
        currentMonster = 0;
        score++; 
        sample = new SoundFile(this, "Monster_Squish.mp3"); }
      else if (currentMonster == 3 && serialValue == 3) { // COPY THIS 4 TIMES
        currentMonster = 0;
        score++; 
        sample = new SoundFile(this, "Monster_Squish.mp3"); }
      else if (currentMonster == 4 && serialValue == 4) { // COPY THIS 4 TIMES
        currentMonster = 0;
        score++; 
        sample = new SoundFile(this, "Monster_Squish.mp3"); }
      }
    }
      //is evil
  //    else if (currentMonster == 3 || currentMonster == 4) {
  //      monsterGameOver();
  //    }
  //  }
  //}

  void monsterGameOver() {
    gameOver = true;
      sample = new SoundFile(this, "Game_Over.mp3"); 
  }
}

class Timer {

  int savedTime; //when timer starts
  int totalTime; //how long the timer should go for
  int passedTime;

  Timer(int time) {
    totalTime = time;
  }

  void startTimer() {
    savedTime = millis()/1000; //seconds
  }

  boolean isFinished() {
    passedTime = (millis()/1000) - savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}