//void setup() {
//  // put your setup code here, to run once:
//  // initialize the serial communication
//  pinMode(A0,INPUT);
//    pinMode(A1,INPUT);
//  Serial.begin(9600);
//
//}
//
//void loop() {
//  // put your main code here, to run repeatedly:
//  //send the value of analog input 0
//  // Serial.println(analogRead(A0));
//   delay(20);
//
//  float s1 = analogRead(A0);
//  delay(10);
//  float s2 = analogRead(A1);
//  delay(10);
////  float s3 = analogRead(A2);
////  delay(100);
////  float s4 = analogRead(A3);
////  delay(100);
//

//delay(100);
//}

// these constants won't change:
const int ledPin = 13;      // LED connected to digital pin 13
const int knockSensor[4] = { A0, A1, A2, A3}; // the piezo is connected to analog pin 0
const int threshold = 5;  // threshold value to decide when the detected sound is a knock or not

// these variables will change:
int sensorReading[4] = {0, 0, 0, 0};      // variable to store the value read from the sensor pin
int ledState = LOW;         // variable used to store the last LED status, to toggle the light

void setup() {
  pinMode(ledPin, OUTPUT); // declare the ledPin as as OUTPUT
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);

  Serial.begin(9600);       // use the serial port
}

void loop() {

  for (int i = 0; i < 4; i++) {
    sensorReading[i] = analogRead(knockSensor[i]); // read the sensor and store it in the variable sensorReading:
   // Serial.println(sensorReading[i]);

    // if the sensor reading is greater than the threshold:
    //if (sensorReading[i] >= threshold) {
    //ledState = !ledState; // toggle the status of the ledPin:
    //  digitalWrite(ledPin, ledState); // update the LED pin itself:
    //      Serial.print("Knock detected at "); // send the string "Knock!" back to the computer, followed by newline
    //      Serial.println(i);
    //}
  }

  Serial.print("S1:");
  Serial.print(sensorReading[0]);
  Serial.print(",");

  Serial.print("S2:");
  Serial.print(sensorReading[1]);
  Serial.print(",");

  Serial.print("S3:");
  Serial.print(sensorReading[2]);
  Serial.print(",");

  Serial.print("S4:");
  Serial.print(sensorReading[3]);
  Serial.print(",");



  delay(150);  // delay to avoid overloading the serial port buffer
}

