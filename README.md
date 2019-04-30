# painting-sound

## paintingSound
- This will probably used as the actual project file.
- __paintingSound__ contains the `setup` and `draw` functions
- __Camera__ wraps webcam stuff, `update` returns a PImage to be fed into the Detector class
- __Detector__ wraps OpenCV stuff, `get` functions return PVectors and stuff to be used by code that generates sound and visuals

## test_detectPaint
- Uses a screencast video of a MSPaint-ish app to imitate webcam input.
- Uses background subtraction to detect and draw a stroke around newly painted areas
- Uses optical flow to calculate and print out a vector of average movement dx and dy
__Libraries needed:__ Video, OpenCV

## test_webcamPaint
- Uses webcam footage to do the same stuff as above. (Note the use of a 3rd party java library instead of the Video library because it wasn't working on my laptop.)
- Detects and draws a stroke around shapes (aka contours)
- Uses optical flow to calculate and print out a vector of average movement dx and dy
__Libraries needed:__ OpenCV

## test_webcamCrop
- Crops webcam footage into a smaller frame
- Use arrow buttons and +/- to translate and zoom
