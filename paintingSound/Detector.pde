import gab.opencv.*;
OpenCV opencv;

import java.awt.Rectangle;

float flowThreshold = 0.03;
float areaThreshold = 100;
int pixelThreshold = 120; // should be between 135 and 140

class Detector {
  
  ArrayList<Contour> allContours;
  ArrayList<Contour> newContours;
  PVector prevFlow = new PVector();
  PVector flow;
  
  Detector(PApplet parent) {
    opencv = new OpenCV(parent, frameW, frameH);
    opencv.startBackgroundSubtraction(5, 3, 0.9);
  }
  
  void update(PImage screen) {
    opencv.loadImage(screen);
    
    
    /****** background subtraction ******/
    
    opencv.updateBackground();
    opencv.dilate();
    opencv.erode();
    newContours = opencv.findContours();
    
    
    /****** detect shapes ******/
    
    // opencv.brightness((int) map(mouseX, 0, width, -200, 200));
    // opencv.contrast((int) map(mouseX, 0, width, -200, 200));
    opencv.gray();
    opencv.threshold(pixelThreshold);
    // image(opencv.getOutput(), 0, 0);
    allContours = opencv.findContours();
    
    
    /****** detect movement ******/
    
    prevFlow = flow;
    opencv.calculateOpticalFlow();
    flow = opencv.getAverageFlow();
  }
  
  PVector getFlow() {
    return flow;
  }
  
  PVector getNewLocation() {
    Contour c = findLargest(newContours);
    if (c == null || c.area() < areaThreshold) {
      return null; 
    }
    Rectangle box = c.getBoundingBox();
    return findCenter(box);
  }
  
  boolean checkMoving() {
    return flow.mag() > flowThreshold;
  }
  
  int checkDirectionChange() {
    if (checkMoving() && PVector.angleBetween(prevFlow, flow) > radians(90)) {
      return flipCoin();
    } else {
      return 0;
    }
  }
  
  ArrayList<Contour> getAllContours() {
    return allContours;
  }
  
  /**************** helpers *****************/
  
  int flipCoin() {
    return floor(random(0, 2)) * 2 - 1;
  }
  
  private Contour findLargest(ArrayList<Contour> contours) {
    float biggestArea = 0;
    Contour biggest = null;
    for (Contour c: contours) {
      if (c.area() > biggestArea) {
        biggestArea = c.area();
        biggest = c;
      }
    }
    return biggest;
  }
  
  private PVector findCenter(Rectangle box) {
    float x = (float) (box.getX() + box.getWidth() / 2);
    float y = (float) (box.getY() + box.getHeight() / 2);
    return new PVector(x, y);
  }
  
  
  /**************** DEBUGGING SHIT *****************/
  
  void drawDebug(boolean allC, boolean newC, boolean f) {
    noFill();
    strokeWeight(3);
    pushMatrix();
    colorMode(RGB);
    translate((width-frameW)/2, (height-frameH)/2);
    if (allC) drawAllContours();
    if (newC) drawNewContours();
    if (f) drawFlow();
    popMatrix();
  }
  
  private void drawAllContours() {
    stroke(0, 0, 255);
    for (Contour contour : allContours) {
      contour.draw();
    }
  }
  
  private void drawNewContours() {
    stroke(255, 0, 0);
    for (Contour contour : newContours) {
      contour.draw();
    }
  }
  
  private void drawFlow() {
    float posx = map(flow.x, -1, 1, -(frameW/2), frameW/2);
    float posy = map(flow.y, -1, 1, -(frameH/2), frameH/2);
    stroke(0, 255, 0);
    line(frameW/2, frameH/2, posx+(frameW/2), posy+(frameH/2));
  }
  
}
