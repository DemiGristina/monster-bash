import processing.serial.*;

Serial myPort; // create object from Serial class

float sensor1 = 0;
float sensor2 = 0;
float sensor3 = 0;
float sensor4 = 0;

void setup() {
  size(800, 600);
  background(0);
  printArray(Serial.list()); // prints all connected serial devices
  String portName = Serial.list()[2]; // whatever the number is
  myPort = new Serial(this, portName, 9600); // set the serial rate
  // don't generate a serialEvent() unless you get a new line character
  myPort.bufferUntil(','); // enables to split data via a comma
}

void draw() {
  background(0);

  fill(0, 0, 255);
  ellipse(width*0.3, height/2, sensor1*3, sensor1*3);

  fill(0, 0, 255);
  ellipse(width*0.3, height/2, sensor2*3, sensor2*3);


  fill(0, 0, 255);
  ellipse(width*0.3, height/2, sensor3*3, sensor3*3);

  fill(0, 0, 255);
  ellipse(width*0.3, height/2, sensor4*3, sensor4*3);
}

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
        println("Knock1");
      }
    }

    if (label.equals("S2")) {
      println("looks like sensor 2 was "+val);
      sensor2 = float(val);

      if (sensor2>5) {
        println("Knock2");
      }
    }
    
    
    if (label.equals("S3")) {
      println("looks like sensor 3 was "+val);
      sensor3 = float(val);

      if (sensor3>5) {
        println("Knock3");
      }
    }  
    
    
    if (label.equals("S4")) {
      println("looks like sensor 4 was "+val);
      sensor4 = float(val);

      if (sensor4>5) {
        println("Knock4");
      }
    }
    
  }
}