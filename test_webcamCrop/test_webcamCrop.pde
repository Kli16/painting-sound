
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
int camW = 1280;
int camH = 720;
int dx, dy;

int frameW = 600;
int frameH = 600;

int frameX = (camW - frameW) / 2;
int frameY = (camH - frameH) / 2;

int imgW = 1280;
int imgH = 720;

int ix = 0;
int iy = 0;

void setup() {
  size(1280, 720);
  
  println(Webcam.getWebcams());
  if (Webcam.getWebcams().size() > 1) {
    webcam = Webcam.getWebcams().get(whichWebcam);
  } else {
    webcam = Webcam.getDefault();
  }
  webcam.setCustomViewSizes(new Dimension(camW, camH));
  webcam.setViewSize(new Dimension(camW, camH));
  webcam.open(true);
  
  BufferedImage bimg = webcam.getImage();
  println(bimg.getWidth());
  println(bimg.getHeight());
  
  dx = (bimg.getWidth() - width)/2;
  dy = (bimg.getHeight() - height)/2;
}

void draw() {
  background(0);
  PImage screen = getCroppedCapture();
  image(screen, frameX, frameY);
}

void keyPressed() {
  if (key == '-') {
    imgW -= 2;
    imgH -= 2;
  } else if (key == '+') {
    imgW += 2;
    imgH += 2;
  } else if (keyCode == UP) {
    iy += 1;
  } else if (keyCode == DOWN) {
    iy -= 1;
  } else if (keyCode == LEFT) {
    ix -= 1;
  } else if (keyCode == RIGHT) {
    ix += 1;
  } 
}

PImage getCroppedCapture() {
  BufferedImage bimg = webcam.getImage();
  PImage pimg = new PImage(bimg);
  pimg.resize(imgW, imgH);
  PImage screen = pimg.get(frameX + ix, frameY + iy, frameW, frameH);  
  return screen;
}
