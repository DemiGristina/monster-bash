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
// // Serial.print("S1:");
//  Serial.print(s1);
//  Serial.print(",");    
//  Serial.println();
//
// // Serial.print("S2:");
//  Serial.print(s2);
//  Serial.print(",");
//  Serial.println();
//
////  Serial.print("S3:");
////  Serial.print(s3);
////  Serial.print(",");
////
////  Serial.print("S4:");
////  Serial.print(s4);
////  Serial.print(",");
//delay(100);
//}

// these constants won't change:
const int ledPin = 13;      // LED connected to digital pin 13
const int knockSensor = A0; // the piezo is connected to analog pin 0
const int threshold = 4;  // threshold value to decide when the detected sound is a knock or not

// these variables will change:
int sensorReading = 0;      // variable to store the value read from the sensor pin
int ledState = LOW;         // variable used to store the last LED status, to toggle the light

void setup() {
  pinMode(ledPin, OUTPUT); // declare the ledPin as as OUTPUT
  Serial.begin(9600);      // use the serial port
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  sensorReading = analogRead(knockSensor);
  Serial.println(sensorReading);

  // if the sensor reading is greater than the threshold:
  if (sensorReading >= threshold) {
    // toggle the status of the ledPin:
    ledState = !ledState;
    // update the LED pin itself:
    digitalWrite(ledPin, ledState);
    // send the string "Knock!" back to the computer, followed by newline
    Serial.println("Knock!");
  }
  delay(100);  // delay to avoid overloading the serial port buffer
}

