
void assignKnobNames(){
  if (sensorValues != null) {
    bot1 = sensorValues[0];
    bot2 = sensorValues[1];
    bot3 = sensorValues[2];
    bot4 = sensorValues[5];
    bot5 = sensorValues[6];
    bot6 = sensorValues[7];
    top1 = sensorValues[3];
    top2 = sensorValues[4];
    top3 = sensorValues[8];
    top4 = sensorValues[9];
    
    /*
    fill(220,180);
    ellipse(scl * 3, height/2, top1, top1);
    ellipse(scl * 4, height/2, top2, top2);
    ellipse(scl*8, height/2, top3, top3);
    ellipse(scl*9, height/2, top4, top4);
    ellipse(scl*0, height/2, bot1, bot1);
    ellipse(scl*1, height/2, bot2, bot2);
    ellipse(scl*2, height/2, bot3, bot3);
    ellipse(scl*5, height/2, bot4, bot4);
    ellipse(scl*6, height/2, bot5, bot5);
    ellipse(scl*7, height/2, bot6, bot6);
    */
  }
}

void setupSerialPort(){
  // Print a list of the serial ports, for debugging purposes:
  printArray(Serial.list());
  // Open the serial port whose index matches the arduino input from Serial.list
  myPort = new Serial(this, Serial.list()[3], 9600);
  // Generate a serialEvent only after receiving a full array AND /n
  myPort.bufferUntil('\n');
  // Clear the serial buffer:
  myPort.clear();
}

void drawTestGraph(){
  // if there are sensor values, graph them:
  if (sensorValues != null) {
    // how many sensors? As many as are in the array:
    int sensorCount = sensorValues.length;
    // iterate over the array, draw a bar for each one:
    for (int thisSensor = 0; thisSensor < sensorCount; thisSensor++) { 
      // Divvy up screen width to makae room for each sensor
      float hPos = (thisSensor* width/sensorCount);
      // calculate the height of the bar based on the sensor value:
      float sensorHeight = map(sensorValues[thisSensor], 0, 1023, 0, height);
      float barColor = map(sensorValues[thisSensor], 0, 1023, 0, 255);
      fill (barColor);
      // calculate the starting vertitical position based on the height:
      float yPos = height - sensorHeight;
      // draw the bar:
      rect (hPos, yPos, width/sensorCount, sensorHeight);
      text("index: " + thisSensor, hPos, yPos);
     
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