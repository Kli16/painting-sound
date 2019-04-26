

import processing.video.*;
import gab.opencv.*;

Movie video;
OpenCV opencv;

ArrayList<Contour> contours;
Contour prevContour;

void setup() {
  size(1280, 720);
  video = new Movie(this, "paint.mp4"); //<>//
  opencv = new OpenCV(this, 1280, 720);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  video.loop();
  video.play();
  while (video.height == 0) delay(10);
}

void draw() {
  image(video, 0, 0);  
  opencv.loadImage(video);
  
  // opencv.gray();
  // opencv.threshold(70);
  // PImage dst = opencv.getOutput();
  // image(dst, 0, 0);

  opencv.calculateOpticalFlow();
  PVector flow = opencv.getAverageFlow();
  println(flow);
  drawVector(flow.x, flow.y);
  
  opencv.updateBackground();
  opencv.dilate();
  opencv.erode();
  contours = opencv.findContours();
  
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


void movieEvent(Movie m) {
  m.read();
}

/**************** ignore this lmao *****************/

/*
import gab.opencv.*;

PImage src, dst;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

void setup() {
  src = loadImage("test.jpg"); 
  size(1080, 360);
  opencv = new OpenCV(this, src);

  opencv.gray();
  opencv.threshold(70);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
}

void draw() {
  scale(0.5);
  image(src, 0, 0);
  image(dst, src.width, 0);

  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
}
*/
