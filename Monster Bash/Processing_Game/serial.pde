import processing.serial.*;

Serial myPort; // create object from Serial class

float sensor1 = 0;
float sensor2 = 0;
float sensor3 = 0;
float sensor4 = 0;


boolean hit1 = false;
boolean hit2 = false;
boolean hit3 = false;
boolean hit4 = false;



void serialEvent (Serial myPort) {

  String inString = myPort.readStringUntil(',');
  String items[] = split(inString, ':'); 

  if (items.length > 1) {
    String label = trim(items[0]);
    String val = split(items[1], ',')[0];

    if (label.equals("S1")) {
      println("looks like sensor 1 was "+val);
      sensor1 = float(val);

      if (sensor1>5) {
        println("HIT MONSTER 1");
        //width-(width/4), height-((height/4)*3)
        //width-(width/4), height-((height/4)*3)
        hx=width/4;
        hy=height-((height/4)*3);
        hit1=true;
      } else {
        hit1=false;
      }
    }

    if (label.equals("S2")) {
      println("looks like sensor 2 was "+val);
      sensor2 = float(val);

      if (sensor2>5) {
        println("HIT MONSTER 2");
        //width-(width/4), height-((height/4)*3)
        //width/4, height-((height/4)*3));
        hx=width-(width/4);
        hy=height-((height/4)*3);
        hit2=true;
      } else {
        hit2=false;
      }
    }


    if (label.equals("S3")) {
      println("looks like sensor 3 was "+val);
      sensor3 = float(val);

      if (sensor3>5) {
        println("HIT MONSTER 3");
        //width-(width/4), height-((height/4)*3)
        //width/4, height-((height/4)*3));
        //width/4, height-(height/4));
        hx=(width/4);
        hy=height-(height/4);
        hit3=true;
      } else {
        hit3=false;
      }
    }  


    if (label.equals("S4")) {
      println("looks like sensor 4 was "+val);
      sensor4 = float(val);

      if (sensor4>5) {
        println("Knock4");
        
        hx=width-(width/4);
        hy=height-(height/4);
        hit3=true;
      } else {
        hit3=false;
      }
    }
  }
}