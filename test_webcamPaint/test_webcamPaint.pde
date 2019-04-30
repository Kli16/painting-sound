
import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamPanel;
import com.github.sarxos.webcam.WebcamResolution;
import java.awt.image.BufferedImage;
import java.awt.Dimension;
Webcam webcam;

import gab.opencv.*;
OpenCV opencv;

int whichWebcam = 1;

// Variables for resizing webcam output to screen output
int w = 1280; // 1280
int h = 720; // 720
int dx, dy;

ArrayList<Contour> allContours;
ArrayList<Contour> newContours;

void setup() {
  size(600, 600);
  setupWebcam();
  opencv = new OpenCV(this, w, h);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {
  PImage screen = getCroppedCapture();
  image(screen, 0, 0);
  opencv.loadImage(screen);
  
  
  opencv.updateBackground();
  opencv.dilate();
  opencv.erode();
  newContours = opencv.findContours();
  
  
  // opencv.brightness((int) map(mouseX, 0, width, -200, 200));
  // opencv.contrast(0);
  // image(opencv.getOutput(), 0, 0);
  opencv.gray();
  int threshold = 136; // should be between 135 and 140
  // int threshold = (int) map(mouseX, 0, width, 130, 170);
  opencv.threshold(threshold);
  // println(threshold);
  // image(opencv.getOutput(), 0, 0);
  allContours = opencv.findContours();

  
  opencv.calculateOpticalFlow();
  PVector flow = opencv.getAverageFlow();
  drawVector(flow.x, flow.y);
  
  
  noFill();
  strokeWeight(3);
  stroke(0, 0, 255);
  for (Contour contour : allContours) {
    contour.draw();
  }
  stroke(255, 0, 0);
  for (Contour contour : newContours) {
    contour.draw();
  }
}

// FOR DEBUGGING ONLY
void drawVector(float x, float y) {
  float posx = map(x, -1, 1, 0, 600);
  float posy = map(y, -1, 1, 0, 600);
  stroke(0);
  strokeWeight(3);
  line(300, 300, posx, posy);
}



/**************** webcam stuff *****************/

void setupWebcam() {
  print(Webcam.getWebcams());
  if (Webcam.getWebcams().size() > 1) {
    webcam = Webcam.getWebcams().get(whichWebcam);
  } else {
    webcam = Webcam.getDefault();
  }
  webcam.setCustomViewSizes(new Dimension(w, h));
  webcam.setViewSize(new Dimension(w, h));
  webcam.open(true);
  
  BufferedImage bimg = webcam.getImage();
  
  dx = (w - bimg.getWidth())/2;
  dy = (h - bimg.getHeight())/2;
}

// Crops the webcam capture to canvas size
PImage getCroppedCapture() {
  BufferedImage bimg = webcam.getImage();
  PImage pimg = new PImage(bimg);
  PImage screen = pimg.get(0-dx, 0-dy, w, h);  
  return screen;
}
