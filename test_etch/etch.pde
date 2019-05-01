import processing.serial.*;
import cc.arduino.*;

class etch {
  
  
  int leftPin = 1;
  int left = 0;
  int rightPin = 3;
  int right = 0;


  etch(){
    println(Arduino.list());
    arduino.pinMode(leftPin, Arduino.INPUT);
    arduino.pinMode(rightPin, Arduino.INPUT);
  }
  
  void sketch() {
    left = arduino.analogRead(leftPin);
    right = arduino.analogRead(rightPin);
    float x = map(left, 0, 1023, 0, width);
    float y = map(right, 0, 1023, 0, height);
    circle(x, y, 3);
  }
}
