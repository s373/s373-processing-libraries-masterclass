class SoundPart {

  float x, y;
  float life, lifeinc;

  float rad, amp, freq;

  SineWave sine;


  SoundPart(float _x, float _y) {
    x = _x;
    y = _y;
    life = 0.0f; // 0->2
    lifeinc = random(0.001, 0.01); 

    //freq = map ( y, 0, height, 5200, 1); // linear mapping
    
    // quadratic mappng
    float quadratic = (float) (height-y) / height; // 1-0
    quadratic =  pow(quadratic,4); // 1-0 quadratic        
    freq = map ( quadratic, 0, 1, 100, 5200); // quadratic mapping
    

    sine = new SineWave (    freq, 0., out.sampleRate()  );
   
    sine.portamento(200);
   
    out.addSignal(sine);
  
  }

  void removeAudio() {
    out.removeSignal(sine);
  }

  void update() {
    life += lifeinc;//0.01;

    if (life <=1) {
      amp = life * 0.25;
      rad = map(life, 0, 1, 0, 50);
    } 
    else if (life >1) {
      amp = map (life, 1, 2, 0.25, 0);
      rad = map (life, 1, 2, 50, 0);
    }

    sine.setAmp(amp);
  }


  void draw() {
    ellipse(x, y, rad, rad);
    text(""+freq, x, y+15);
  }
}

