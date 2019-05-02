
import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamPanel;
import com.github.sarxos.webcam.WebcamResolution;
import java.awt.image.BufferedImage;
import java.awt.Dimension;

Webcam webcam;

 
int camW = 1080;
int camH = 720;

int frameW = 1700;
int frameH = 1700;
  
int frameX = (w - frameW) / 2;
int frameY = (h - frameH) / 2;
  
  
class Camera {
  
  int imgW = 720;
  int imgH = 720;
  
  int dx = 0;
  int dy = 0;
  
  int move = 15;
  int scale = 20;
  
  PImage screen;
  
  Camera(int whichWebcam) {
    if (whichWebcam < Webcam.getWebcams().size()) {
      webcam = Webcam.getWebcams().get(whichWebcam);
    } else {
      webcam = Webcam.getDefault();
    }
    webcam.setCustomViewSizes(new Dimension(camW, camH));
    webcam.setViewSize(new Dimension(camW, camH));
    webcam.open(true);
    
    BufferedImage bimg = webcam.getImage();
    // println(bimg.getWidth());
    // println(bimg.getHeight());
    
    // dx = (bimg.getWidth() - width)/2;
    // dy = (bimg.getHeight() - height)/2;
  }
  
  PImage update() {
    keyPress();
    screen = getCroppedCapture();
    return screen;
  }
  
  void keyPress() {
    // if (!showImage) return;
    if (!keyPressed) return;
    
    if (key == '-') {
      imgW -= scale;
      imgH -= scale;
    } else if (key == '+') {
      imgW += scale;
      imgH += scale;
    } else if (keyCode == UP) {
      dy += move;
    } else if (keyCode == DOWN) {
      dy -= move;
    } else if (keyCode == LEFT) {
      dx -= move;
    } else if (keyCode == RIGHT) {
      dx += move;
    }
  }
  
  PImage getCroppedCapture() {
    BufferedImage bimg = webcam.getImage();
    PImage pimg = new PImage(bimg);
    // pimg.resize(imgW, imgH);
    // pimg = pimg.get(frameX + dx, frameY + dy, frameW, frameH); 
    int imgX = (camW - imgW) /2;
    int imgY = (camH - imgH) /2;
    pimg = pimg.get(imgX + dx, imgY + dy, imgW, imgH); //<>//
    pimg.resize(frameW, frameH);
    return pimg;
  }
  
  void display() {
    background(0);
    image(screen, frameX, frameY);
  }
  
}
