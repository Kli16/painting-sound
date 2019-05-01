import processing.serial.*;
import cc.arduino.*;

etch e;
Arduino arduino;

void setup() {
  size(600, 600);
  arduino = new Arduino(this, Arduino.list()[8], 57600);
  e = new etch();
}

void draw() {
  e.sketch();
}
