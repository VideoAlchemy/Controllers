
/* FP_13_demoSketch
j.stephens  - 2016_05_22
Processing 3.1.1 

The F-P13 derives its name from the current possibility
that 13 may be Pregnant with Flynn.
*/

import processing.serial.*;

Serial myPort;    // instance of the serial library
int[] sensorValues = new int[10];  // array to hold the sensor values

void setup() {
  // set the size of the window:
  //size(800,600);
  fullScreen();
  noStroke();
 
  // Print a list of the serial ports, for debugging purposes:
  printArray(Serial.list());
  
  // Open the serial port whose index matches the arduino input from Serial.list
  myPort = new Serial(this, Serial.list()[3], 9600);
  
  // Generate a serialEvent only after receiving a full array AND /n
  myPort.bufferUntil('\n');
 
  // Clear the serial buffer:
  myPort.clear();
  
}

void draw() {
  // nice green background:
  background(99,234,120);
 
  // if there are sensor values, graph them:
  if (sensorValues != null) {
    // how many sensors? As many as are in the array:
    int sensorCount = sensorValues.length;
    // iterate over the array, draw a bar for each one:
    for (int thisSensor = 0; thisSensor < sensorCount; thisSensor++) {
      // calculate the horizontal position of the bar 
      // based on how many sensor reading you have:
      float hPos = (thisSensor* width/sensorCount);
      // calculate the height of the bar based on the sensor value:
      float sensorHeight = map(sensorValues[thisSensor], 0, 1023, 0, height);
      float barColor = map(sensorValues[thisSensor], 0, 1023, 0, 255);
      fill (barColor);
      // calculate the starting vertitical position based on the height:
      float yPos = height - sensorHeight;
      // draw the bar:
      rect (hPos, height - sensorHeight, width/sensorCount, sensorHeight);
   // println(sensorValues[9]);
    }
  }
}

void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);
    // split the string at the commas
    // and convert the sections into integers:
    int sensors[] = int(split(myString, ','));
    // make sure you have enough readings:
    if (sensors.length >= sensorValues.length) {
      // put the readings into the global array:
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        if (sensorNum < sensorValues.length) {
          sensorValues[sensorNum] = sensors[sensorNum]; 
        }
      }
    }
  }
}