import arb.soundcipher.*;

class Sound {
  
  SoundCipher sc;
  int curr_note;
  float[] scale;
  
  Sound(float inst, float[] _scale) {
    sc = new SoundCipher();
    sc.instrument(inst);
    scale = new float[_scale.length * 3];
    for (int i = 0; i < _scale.length; i++) {
      scale[i] = 30 + _scale[i];
    }
    int ind = _scale.length;
    float base = 30 + 12;
    for (int i = 0; i < _scale.length; i++) {
      scale[ind + i] = base + _scale[i];
    }
    ind = _scale.length * 2;
    base += 12;
    for (int i = 0; i < _scale.length; i++) {
      scale[ind + i] = base + _scale[i];
    }
    curr_note = 0;
  }
  
  void jumpup(int n){
    curr_note += n;
    curr_note = curr_note % scale.length;
    sc.playNote(50 + scale[curr_note], (int)random(80)+40, .2);
  }
  
  void jumpdown(int n){
    curr_note -= n;
    while (curr_note < 0) {
      curr_note += scale.length;
    }
    sc.playNote(50 + scale[curr_note], (int)random(80)+40, .2);
  }
  
}
