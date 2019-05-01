import arb.soundcipher.*;

class Sound {
  
  SoundCipher sc;
  int curr_note;
  float[] scale;
  
  Sound(float inst, float[] _scale) {
    sc = new SoundCipher();
    sc.instrument(inst);
    scale = _scale;
    curr_note = 0;
  }
  
  void jumpup(int n){
    curr_note += n;
    curr_note = curr_note % scale.length;
    println(scale.length);
    sc.playNote(50 + scale[curr_note], (int)random(80)+40, .2);
  }
  
  void jumpdown(int n){
    curr_note -= n;
    while (curr_note < 0) {
      curr_note += 6;
    }
    sc.playNote(50 + scale[curr_note], (int)random(80)+40, .2);
  }
  
}
