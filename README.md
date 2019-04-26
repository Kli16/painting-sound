# painting-sound

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
