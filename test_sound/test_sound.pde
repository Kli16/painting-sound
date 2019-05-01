import arb.soundcipher.*;

Sound s;
SoundCipher sc;

void setup() {
  frameRate(8);
  s = new Sound(SoundCipher.GUITAR, SoundCipher.BLUES);
}

void draw() {
  s.jumpup(1);
} 
