int w = 1280;
int h = 720; 

Camera camera;
Detector detector;

PVector flow = new PVector();
PVector newest = new PVector();
boolean isMoving;
boolean isDirectionChange;
ArrayList<Contour> contours;

void setup() {
  size(1280, 720);
  
  camera = new Camera(1);
  detector = new Detector(this);
}

void draw() {
  PImage curr = camera.update();
  camera.display();
  
  detector.update(curr);
  detector.drawDebug(true, true, true);
  
  
  /******* variables to be used for sound/visual generation *******/
  
  flow = detector.getFlow();
  
  newest = detector.getNewLocation();
  if (newest != null) println(newest);
  
  isMoving = detector.checkMoving();
  
  isDirectionChange = detector.checkDirectionChange();
  
  contours = detector.getAllContours();
  
}
