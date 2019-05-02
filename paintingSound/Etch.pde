import processing.serial.*;
import cc.arduino.*;

class Etch {
  
  
  int leftPin = 1;
  int left = 0;
  int rightPin = 3;
  int right = 0;
  
  float prevX = -1;
  float prevY = -1;
  
  Sound s;
  
  ArrayList<PVector> circles = new ArrayList<PVector>();


  Etch(){
    // println(Arduino.list());
    arduino.pinMode(leftPin, Arduino.INPUT);
    arduino.pinMode(rightPin, Arduino.INPUT);
    
    s = new Sound(SoundCipher.PIANO, SoundCipher.BLUES);
  }
  
  void sketch() {
    noStroke();
    fill(gray);
    left = arduino.analogRead(leftPin);
    right = arduino.analogRead(rightPin);
    float x = map(left, 0, 1023, frameX, frameX + frameW);
    float y = map(right, 0, 1023, frameY, frameY + frameH);
    // println(x, y);
    playSound(left, right);
    circles.add(circles.size(), new PVector(x, y)); //<>//
    for (PVector c: circles) {
      circle(c.x, c.y, random(10, 50));
    }
    // circle(x, y, 3);
    prevX = x;
    prevY = y;
  }
  
  void playSound(float x, float y) {
    if (prevX < 0 || prevY < 0) return;
    float dx = x - prevX;
    float dy = y - prevY;
    if (dx > 3) {
      s.jumpup(1);
    } else if (dy > 3) {
      s.jumpdown(1);
    }
  }
}
