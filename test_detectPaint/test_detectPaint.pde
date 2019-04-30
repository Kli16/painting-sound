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

void movieEvent(Movie m) {
  m.read();
}


/******** FOR DEBUGGING ONLY ********/

void drawVector(float x, float y) {
  float posx = map(x, -1, 1, 280, 1000);
  float posy = map(y, -1, 1, 0, 720);
  stroke(0);
  strokeWeight(3);
  line(640, 360, posx, posy);
}
