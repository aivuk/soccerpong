class Pad {

  float h, w, x, y, f, amp, y0, t0;

  Pad(float hi, float wi, float xi, float y0i, float fi, float ampi, float t0i) {
    h = hi;
    w = wi;
    x = xi;
    y0 = y0i;
    f = fi;
    amp = ampi;
    t0 = t0i;

    update(0);
  }

  void draw() {
    rect(x, y, w, h);
  }

  void update(float t) {
    y = y0 - amp*sin(f*(t + t0));
  }
}
