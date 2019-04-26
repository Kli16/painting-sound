
import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamPanel;
import com.github.sarxos.webcam.WebcamResolution;
import java.awt.image.BufferedImage;
import java.awt.Dimension;
Webcam webcam;

import gab.opencv.*;
OpenCV opencv;

// Variables for resizing webcam output to screen output
int w = 1280;
int h = 720;
int dx, dy;

ArrayList<Contour> contours;

void setup() {
  size(1280, 720);
  setupWebcam();
  opencv = new OpenCV(this, 1280, 720);
  
  // opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {
  PImage screen = getCroppedCapture();
  image(screen, 0, 0);
  
  opencv.loadImage(screen);
  opencv.brightness(30);
  opencv.contrast(30);
  // image(opencv.getOutput(), 0, 0);
  
  opencv.gray();
  opencv.threshold(145);
  // image(opencv.getOutput(), 0, 0);
  
  
  // opencv.updateBackground();
  // opencv.dilate();
  // opencv.erode();
  contours = opencv.findContours();

  
  opencv.calculateOpticalFlow();
  PVector flow = opencv.getAverageFlow();
  println(flow);
  drawVector(flow.x, flow.y);
  
  
  noFill();
  stroke(0);
  strokeWeight(3);
  for (Contour contour : contours) {
    contour.draw();
  }
}

// FOR DEBUGGING ONLY
void drawVector(float x, float y) {
  float posx = map(x, -1, 1, 280, 1000);
  float posy = map(y, -1, 1, 0, 720);
  stroke(0);
  strokeWeight(3);
  line(640, 360, posx, posy);
}



/**************** webcam stuff *****************/

void setupWebcam() {
  webcam = Webcam.getDefault();
  // webcam.setViewSize(WebcamResolution.VGA.getSize());
  webcam.setCustomViewSizes(new Dimension(w, h));
  webcam.setViewSize(new Dimension(w, h));
  webcam.open(true);
  
  BufferedImage bimg = webcam.getImage();
}

// Crops the webcam capture to canvas size
PImage getCroppedCapture() {
  BufferedImage bimg = webcam.getImage();
  PImage pimg = new PImage(bimg);
  PImage screen = pimg.get(0-dx, 0-dy, w, h);  
  return screen;
}
