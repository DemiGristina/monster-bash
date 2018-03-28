Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port


void setupArduino() {
  printArray(Serial.list());
  try {
    String portName = Serial.list()[6]; //change this
    myPort = new Serial(this, portName, 9600);  //115200
    println("connected to -->  " +portName);
    myPort.bufferUntil(','); //enables to split the data via a comma which is set in teh arduino code
  } 
  catch (Exception e) {
    println("no device connection found");
  }
}


void serialEvent(Serial myPort) {

  String inString = myPort.readStringUntil(',');
  // split the string into multiple strings
  // where there is a delimter":"

  // println(inString); //data line coming in

  String items[] = split(inString, ':');
  // if there was more than one string after the split
  if (items.length > 1) {
    String label = trim(items[0]);
    // remove the ',' off the end
    String val = split(items[1], ',')[0];

    // check what the label was and update the appropriate variable
    if (label.equals("S1")) {
      serialValue = float(val);
    } 
    // check what the label was and update the appropriate variable
    if (label.equals("S2")) {
       serialValue = float(val);
    } 

    // more if statements for more possible data streams
  }
}