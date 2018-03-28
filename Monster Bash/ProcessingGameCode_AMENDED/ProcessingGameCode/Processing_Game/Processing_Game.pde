import processing.serial.*;
import processing.sound.*;

//initializing variables

SoundFile soundfile1;
SoundFile soundfile2;
SoundFile soundfile3;

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

float hx;
float hy;


void setup() {
  size (1024, 756);
  // fullScreen(); //makes game full screen
  surface.setResizable(true); //game window can be resized without messing with the layout

  imageMode(CENTER);

  textAlign(CENTER);

  score = 0;

  //background loaded

  f = loadFont("PTMono-Regular-48.vlw");

  fill(255);

  timer = new Timer(60);
  timer.startTimer();

  hammer = new PImage[2];
  hammer[0] = loadImage("hammer.png");
  hammer[0].resize(width/2, height/2);
  hammer[1] = loadImage("hammerdown.png");
  hammer[1].resize(width/2, height/2);
  soundfile2 = new SoundFile(this, "Monster_Squish.mp3"); 

  loadImages(); //loadpimages

  topLeft = new Monster(width/4, height-((height/4)*3), 1);
  topRight = new Monster(width-(width/4), height-((height/4)*3), 2);
  bottomLeft = new Monster(width/4, height-(height/4), 4);
  bottomRight = new Monster(width-(width/4), height-(height/4), 3);

  soundfile1 = new SoundFile(this, "Background.mp3");

  printArray(Serial.list()); // prints all connected serial devices
  String portName = Serial.list()[2]; // whatever the number is
  myPort = new Serial(this, portName, 9600); // set the serial rate
  // don't generate a serialEvent() unless you get a new line character
  myPort.bufferUntil(','); // enables to split data via a comma

  hx = width/2;
  hy = height/2;
}


void draw() {
  if (gameOver == false) {
    background(0);
    noCursor();



    //timeLeft = (60 - (millis()/1000));

    timeLeft = (int) (60 - timer.passedTime);

    topRight.display();
    topLeft.display();

    bottomRight.display();
    bottomLeft.display();

    topRight.update();
    topLeft.update();

    bottomRight.update();
    bottomLeft.update();

    displayTimeScore();

    //if (mousePressed) {
    //  image(hammer[1], hx, hy);
    //} else {
    image(hammer[0], hx, hy);
    //}
    
    topLeft.checkHit();  //monster 1
    topRight.checkHit();
    bottomLeft.checkHit();
    bottomRight.checkHit(); //monster 4
    
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
  timer.totalTime = 60;
  timer.startTimer();

  topLeft.currentMonster = 0;
  topRight.currentMonster = 0;

  bottomLeft.currentMonster = 0;
  bottomRight.currentMonster = 0;


  gameOver = false;
}