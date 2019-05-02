import processing.serial.*;
import cc.arduino.*;

class Etch {
  
  
  int leftPin = 1;
  int left = 0;
  int rightPin = 3;
  int right = 0;


  Etch(){
    // println(Arduino.list());
    arduino.pinMode(leftPin, Arduino.INPUT);
    arduino.pinMode(rightPin, Arduino.INPUT);
  }
  
  void sketch() {
    noStroke();
    fill(gray);
    left = arduino.analogRead(leftPin);
    right = arduino.analogRead(rightPin);
    float x = map(left, 0, 1023, frameX, frameX + frameW);
    float y = map(right, 0, 1023, frameY, frameY + frameH);
    circle(x, y, 3);
  }
}
