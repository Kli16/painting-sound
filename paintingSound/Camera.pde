
import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamPanel;
import com.github.sarxos.webcam.WebcamResolution;
import java.awt.image.BufferedImage;
import java.awt.Dimension;

Webcam webcam;

 
int camW = 1280;
int camH = 720;

int frameW = 600;
int frameH = 600;
  

class Camera {
  
  int frameX = (camW - frameW) / 2;
  int frameY = (camH - frameH) / 2;
  
  int imgW = 1280;
  int imgH = 720;
  
  int dx = 0;
  int dy = 0;
  
  PImage screen;
  
  Camera(int whichWebcam) {
    // println(Webcam.getWebcams());
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
    
    dx = (bimg.getWidth() - width)/2;
    dy = (bimg.getHeight() - height)/2;
  }
  
  PImage update() {
    keyPress();
    screen = getCroppedCapture();
    return screen;
  }
  
  void keyPress() {
    if (!keyPressed) return;
    
    if (key == '-') {
      imgW -= 2;
      imgH -= 2;
    } else if (key == '+') {
      imgW += 2;
      imgH += 2;
    } else if (keyCode == UP) {
      dy += 1;
    } else if (keyCode == DOWN) {
      dy -= 1;
    } else if (keyCode == LEFT) {
      dx -= 1;
    } else if (keyCode == RIGHT) {
      dx += 1;
    }
  }
  
  PImage getCroppedCapture() {
    BufferedImage bimg = webcam.getImage();
    PImage pimg = new PImage(bimg);
    pimg.resize(imgW, imgH);
    pimg = pimg.get(frameX + dx, frameY + dy, frameW, frameH);  
    return pimg;
  }
  
  void display() {
    background(0);
    image(screen, frameX, frameY);
  }
  
}
