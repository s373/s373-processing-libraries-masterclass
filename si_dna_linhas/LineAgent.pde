class LineAgent {

  int numLines;
  float sx,sy; // size 
  float cx,cy; // relative center of origin
  float growamt;
  int growIters;

  DNA dna;
  ArrayList lines = new ArrayList();
  float locx, locy;

  LineAgent(float _x, float _y) {
    locx = _x;
    locy = _y;
    dna = new DNA(7);
    calcFromDna();
  }

  void calcFromDna() {
    numLines = (int) (dna.getGene(0) * 100);
    sx = dna.getGene(1) * 200;
    sy = dna.getGene(2) * 200;
    cx = dna.getGene(3) * 50;
    cy = dna.getGene(4) * 50;
    growamt = dna.getGene(5) * 10;
    growIters = (int) (dna.getGene(6) * 100.0f);
    clear();
  }

  void clear() {
    lines.clear();
    PVector origin = new PVector(locx+cx, locy+cy);
    for(int i=0; i<numLines; i++) {
      Line l = new Line(origin, origin);
      lines.add(l);
    }
  }

  void render() {
    update();
    draw();
  }
  
  void update() {
//    println("grow "+growIters);
    if(growIters-- > 0) {
      for(int i=0; i<lines.size(); i++) {
        Line l = (Line ) lines.get(i);
        l.growA(growamt);
      }
    }
  }
  void draw() {

    //    pushMatrix();
    //    translate(locx,locy);

    for(int i=0; i<lines.size(); i++) {
      Line l = (Line ) lines.get(i);
      l.draw();
    }

    //    popMatrix();
  }


  void mutate(float m) {
    dna.mutate(m);
    calcFromDna();
  }
}



class Line {

  PVector a, b;

  ArrayList segs;

  Line( PVector _a, PVector _b ) {
    a = new PVector(_a.x, _a.y);
    b = new PVector(_b.x, _b.y);

    segs = new ArrayList();
    segs.add(a);

  }


  void growA(float amt) {
    a.x += random(-amt,amt);
    a.y += random(-amt,amt);

    PVector d = new PVector(a.x, a.y);
    segs.add(d);

    //    b.x += random(-amt,amt);
    //    b.y += random(-amt,amt);
  }

  void draw() {

    //     line(a.x, a.y, b.x, b.y); 

//    println("segs size "+segs.size());

    for(int i=0;i<segs.size()-1;i++) {
      PVector s, d;
      s = (PVector) segs.get(i);
      d = (PVector) segs.get(i+1);
      line(s.x, s.y, d.x, d.y);
    }
  }
}

