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

int w = 1280;
int h = 720; 

Camera camera;
Detector detector;

PVector flow = new PVector();
PVector newest = new PVector();
boolean isMoving;
boolean isDirectionChange;
ArrayList<Contour> contours;

// detected distance in CM
int dist;

void setup() {
  size(1280, 720);
  
  camera = new Camera(1);
  detector = new Detector(this);
  setupRadar(this);
  
}

void draw() {
  PImage curr = camera.update();
  camera.display();
  
  detector.update(curr);
  detector.drawDebug(true, true, true);
  
  
  /******* variables to be used for sound/visual generation *******/
  
  flow = detector.getFlow();
  
  // note this may be null if no movement detected
  newest = detector.getNewLocation();
  // if (newest != null) println(newest);
  
  isMoving = detector.checkMoving();
  
  isDirectionChange = detector.checkDirectionChange();
  
  contours = detector.getAllContours();
  
  drawDistance();
  
}
