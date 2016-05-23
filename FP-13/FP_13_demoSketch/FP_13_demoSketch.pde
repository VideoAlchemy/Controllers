
/* FP_13_demoSketch
j.stephens  - 2016_05_22
Processing 3.1.1 

The F-P13 derives its name from the current possibility
that 13 may be Pregnant with Flynn.
*/

import processing.serial.*;

Serial myPort;                       // instance of the serial library
int[] sensorValues = new int[10];    // array to hold the sensor values

int top1, top2, top3, top4;
int bot1, bot2, bot3, bot4, bot5, bot6;
float scl;

void setup() {
  size(600,600);
  //fullScreen();
  noStroke();
  setupSerialPort();
  scl = width/sensorValues.length;
}  

void draw() {
  background(99,234,120);
  //drawTestGraph();
  assignKnobNames();
  
  ellipse(width/2, height/2, top1, top1);
}