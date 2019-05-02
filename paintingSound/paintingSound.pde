/*
 *  PAINTING SOUND
 *  DESINV 23 - Spring 2019
 *
 *  With code adapted from:
 *  https://github.com/atduskgreg/opencv-processing/blob/master/examples/BackgroundSubtraction/BackgroundSubtraction.pde
 *  https://www.instructables.com/id/Arduino-Processing-HC-SR04-RADAR-Using-Processing-/
 * 
 */
 
 
import cc.arduino.*;
Arduino arduino;

int w = 3200;
int h = 1800; 

Camera camera;
Detector detector;
Sound s;
Etch e;

boolean showImage = true;

PVector flow = new PVector();
PVector newest = new PVector();
boolean isMoving;
int direction;
ArrayList<Contour> contours;

int gray = 150;

void setup() {
  size(3200, 1800);
  
  frameRate(12);
  
  camera = new Camera(1);
  detector = new Detector(this);
  s = new Sound(SoundCipher.GUITAR, SoundCipher.BLUES);
  
  if (Arduino.list().length > 0) {
    arduino = new Arduino(this, Arduino.list()[0], 57600);
    e = new Etch();
  }
}

void draw() {
  background(0);
  PImage curr = camera.update();
  detector.update(curr);
  
  
  /******* variables to be used for sound/visual generation *******/
  
  flow = detector.getFlow();
  
  // note this may be null if no movement detected
  newest = detector.getNewLocation();
  
  isMoving = detector.checkMoving();
  
  direction = detector.checkDirectionChange();
  // if (isMoving) println(direction);
  
  if (e != null) {
    e.sketch();
  }
  
  if (!showImage) {
    contours = detector.getAllContours();
    drawContours(contours);
    drawCircle(newest, flow.mag());
  
    if (direction > 0) s.jumpup(1);
    if (direction < 0) s.jumpdown(1);
  } else {
    camera.display();
    detector.drawDebug(true, true, true);
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    showImage = !showImage;
  }
}

/*
int maxLen = 5;
ArrayList<PVector> locs = new ArrayList<PVector>();
float[] rs = {};
*/

void drawCircle(PVector loc, float flow) {
  if (loc == null) return;
  if (showImage) return;
  noFill();
  stroke(gray);
  strokeWeight(10);
  pushMatrix();
  translate((width-frameW)/2, (height-frameH)/2);
  float r = map(flow, 0, 5, 300, 800);
  ellipse(loc.x, loc.y, r, r);
  popMatrix();
}

void drawContours(ArrayList<Contour> contours) {
  if (showImage) return;
  noFill();
  stroke(gray);
  strokeWeight(6);
  pushMatrix();
  translate((width-frameW)/2, (height-frameH)/2);
  for (Contour contour : contours) {
    if (contour.area() > 200 && contour.area() < 1000000) {
      contour.draw();
    }
  }
  popMatrix();
}
