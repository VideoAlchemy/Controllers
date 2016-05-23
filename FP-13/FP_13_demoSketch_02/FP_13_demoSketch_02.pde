
/* FP_13_demoSketch
 j.stephens  - 2016_05_22
 Processing 3.1.1 
 
 The F-P13 derives its name from the current possibility
 that 13 may be Pregnant with Flynn.
 */

import processing.serial.*;

Serial myPort;                       // instance of the serial library
int[] sensorValues = new int[10];    // array to hold the sensor values

boolean centerMode = false;
int top1, top2, top3
, top4;
int bot1, bot2, bot3, bot4, bot5, bot6;
float scl;
float x, y, w, h, r1, tx, ty;
float x2, y2, w2, h2, r2, tx2, ty2;
float x3, y3, w3, h3, r3, tx3, ty3;
float alpha;

// PImage arrays to hold the source images.
int numOfEmblems   = 99; //total = 25 
PImage[] images = new PImage[numOfEmblems];
int imageIndex  = int(random(numOfEmblems));
int imageIndex2 = int(random(numOfEmblems));
int imageIndex3 = int(random(numOfEmblems));

float rot = 0;
float rspeed;

String SNAP_FOLDER_PATH = "../../../../Dropbox/_SNAPS/2016_fp_13/";

void setup() {
  size(1024, 768, P2D);
  
  //fullScreen();
  background(0);
  noStroke();
  setupSerialPort();
  scl = width/sensorValues.length;

  for (int i=0; i<numOfEmblems; i++) {
    images [i] = loadImage("fp_13_demo_" + i + ".jpg");
  }

  alpha = 255;
  r1 = random(-200, 200);
  tx = random(-20, 20);
  ty = random(-20, 20);

  x2 = random(-100, 100);
  y2 = random(-100, 100);
  w2 = random(-100, 100);
  h2 = random(-100, 100);
  r2 = random(-100, 100);
  tx2 = random(-20, 20);
  ty2 = random(-20, 20);

  x3 = random(-100, 100);
  y3 = random(-100, 100);
  w3 = random(-100, 100);
  h3 = random(-100, 100);
  r3 = random(-200, 200);
  tx3 = random(-20, 20);
  ty3 = random(-20, 20);
}  

void draw() {
  tint(255, alpha);

  if (centerMode) {
    imageMode(CENTER);
  } else {
    imageMode(CORNER);
  }

  //background(99, 234, 120);
  //drawTestGraph();
  assignKnobNames();
  translate(width/2, height/2);
  rotate(rot);

  float x = map(top1, 0, 1023, -width*2, width*2);
  float y = map(top2, 0, 1023, -height*2, height*2);
  float w = map(top3, 0, 1023, -width*2, width*2);
  float h = map(top4, 0, 1023, -height*2, height*2);

  alpha = map(bot2, 0, 1023, 0, 255);

  //r1
  pushMatrix();
  translate(tx, ty);
  rotate(r1);
  image(images[imageIndex], x, y, w, h);
  popMatrix();

  //r2
  pushMatrix();
  translate(tx2, ty2);
  rotate(r2);
  image(images[imageIndex2], x*x2, y*y2, w+w2, h+h2);
  popMatrix();

  //r3
  pushMatrix();
  translate(tx3, ty3);
  rotate(r3);
  image(images[imageIndex3], x+x3, y+y3, w+w3, h+h3);
  popMatrix();

  imageIndex = int(map(bot1, 10, 1023, 0, numOfEmblems));
  imageIndex2 = int(map(bot1, 10, 1023, numOfEmblems, 0));
  imageIndex3 = int(map(bot1, 10, 1023, 0, numOfEmblems*.5));

  rspeed = map(bot3, 0, 1023, -5, 5);
  //println(bot4);

  r1 = map(bot4, 0, 1023, -5, 5);
  r2 = map(bot5, 0, 1023, -5, 5);
  r3 = map(bot6, 0, 1023, -5, 5);
  rot += rspeed;
}  

void mousePressed() {
  imageIndex = int(random(numOfEmblems));
  imageIndex2 = int(random(numOfEmblems));
  imageIndex3 = int(random(numOfEmblems));

  //1
  r1 = random(-200, 200);
  tx = random(-20, 20);
  ty = random(-20, 20);

  //x2 = random(-100,100);
  x2 = random(-2, 2);
  y2 = random(-2, 2);
  w2 = random(-100, 100);
  h2 = random(-100, 100);
  r2 = random(-100, 100);
  tx2 = random(-20, 20);
  ty2 = random(-20, 20);

  x3 = random(-100, 100);
  y3 = random(-100, 100);
  w3 = random(-100, 100);
  h3 = random(-100, 100);
  r3 = random(-200, 200);
  tx3 = random(-20, 20);
  ty3 = random(-20, 20);
}

void keyPressed() {
  if (key == ENTER) {
    centerMode = !centerMode;
  }
   //////////////////////////////////////////////////
  //  SCREEN CAPTURE  =  ENTER
  //////////////////////////////////////////////////
  if (key==TAB) {
    String filename = nowAsString() + ".png";
    println("SAVED AS "+filename);
    saveFrame(SNAP_FOLDER_PATH + filename);
    //saveFrame(SNAP_FOLDER_PATH + "screen-####.png");
    noCursor();
  } else {
    cursor();
  }
}

////////////////////////////////////////////////////
//    SCREEN SNAPS
// output: right now + project + version as a string
// 2015-03-15_portal-control/portal-control_v0.5.3_01-42-50
String nowAsString() {
  return nf(year(), 4)+"-"+
    nf(month(), 2)+"-"+
    nf(day(), 2)+"_"+
    /*project+"/"+
    project+"_"+
    version+"_"+*/
    nf(hour(), 2)+"-"+
    nf(minute(), 2)+"-"+
    nf(second(), 2);
}
// Save the current screen state as a .png in the SNAP_FOLDER_PATH,
// If you pass a filename, we'll use that, otherwise we'll default to the current date.
// NOTE: do NOT pass the ".jpg" or the path.
// Returns the name of the file saved.
String saveScreen() {
  return saveScreen(null);
}
String saveScreen(String fileName) {
  if (fileName == null) {
    fileName = nowAsString();
  }
  save(SNAP_FOLDER_PATH + fileName + ".png");
  println("SAVED AS "+fileName);
  return fileName;
}