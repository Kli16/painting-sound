
import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;
Serial myPort; // defines Object Serial

void setupRadar(PApplet parent) {
  // starts the serial communication
  Serial myPort = new Serial(parent, Serial.list()[0]); 
  
  // reads the data from the serial port up to the character '.'
  // So actually it reads this: angle,distance.
  myPort.bufferUntil('.'); 
}

void serialEvent (Serial myPort) {
  // reads the data from the Serial Port up to the character '.'
  String data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);  
  dist = int(data);
  println(dist);
}

void drawDistance() {
  // dist is a global variable
  noStroke();
  colorMode(HSB, 100);
  fill((int)map(float(dist), 0, 150, 0, 100), 80, 100);
  ellipse(100, 100, 100, 100);
  
}
