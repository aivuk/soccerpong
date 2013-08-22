float v_x = 20;
float b_s = 20;
float side_space = 80;
float pad_s = 20;
float b_x = side_space + pad_s;

float pad_h = 80;

float pad1_y;
float pad1_x = 220;
float pad1_w = PI/((1920 - 2*side_space - 2*pad_s)/v_x);
float pad1_dy = 30;

float pad2_x = 400;
float pad2_w = pad1_w;

float pad3_x = 600;
float pad4_x = 800;

ArrayList<Pad> pads = new ArrayList<Pad>();

float t = 0;
float dt = 1;

boolean stop = true;

void setup () {
  size(1920, 1080);

  // Left team
  //
  pads.add(new Pad(pad_h, pad_s, pad1_x,  height/2  - 3*pad_h/2 - 6*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad1_x, height/2  + 3*pad_h/2 - 6*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad1_x, height/2  + 9*pad_h/2 - 6*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad2_x,  height/2  - 2*pad_h/2 - 6*pad1_dy - 12, -pad2_w, (height/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad2_x, height/2  + 6*pad_h/2 - 6*pad1_dy - 12, -pad2_w, (height/6), pad2_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad3_x,  height/2  - 3*pad_h/2 - 5*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad3_x, height/2  + 3*pad_h/2 - 5*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad3_x, height/2  + 9*pad_h/2 - 5*pad1_dy - 12, pad1_w, (height/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad4_x,  height/2  -2*pad_h/2 - 6*pad1_dy - 12, -pad2_w, (height/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad4_x, height/2  + 4*pad_h/2 - 6*pad1_dy - 12, -pad2_w, (height/6), pad2_x/abs(v_x)));

  // Right team

  pads.add(new Pad(pad_h, pad_s,900 +  pad1_x,  height/2  - 3*pad_h/2 - 6*pad1_dy - 22, -pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad1_x, height/2  + 3*pad_h/2 - 6*pad1_dy - 2, -pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad1_x, height/2  + 9*pad_h/2 - 6*pad1_dy + 12, -pad1_w, (height/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s,900 +  pad2_x,  height/2  - 2*pad_h/2 - 6*pad1_dy - 15, pad2_w, (height/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad2_x, height/2  + 6*pad_h/2 - 6*pad1_dy +15, pad2_w, (height/6), pad2_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s,900 +  pad3_x,  height/2  - 3*pad_h/2 - 5*pad1_dy - 7, -pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad3_x, height/2  + 3*pad_h/2 - 5*pad1_dy + 25, -pad1_w, (height/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad3_x, height/2  + 9*pad_h/2 - 5*pad1_dy + 25, -pad1_w, (height/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s,900 +  pad4_x,  height/2  -2*pad_h/2 - 6*pad1_dy - 12, pad2_w, (height/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s,900 +  pad4_x, height/2  + 4*pad_h/2 - 6*pad1_dy - 12, pad2_w, (height/6), pad2_x/abs(v_x)));

}

void draw () {
    if (!stop)
      t += dt;

    background(color(2, 152, 52));
    fill(255);
    noStroke();
//    textSize(25);
//    text(b_x + "  " + pad1_y, width/2, 100);
    rect(b_x, height/2.0 - b_s/2.0, b_s, b_s);

    // Draw goalies
    rect(side_space, height/2 - pad_h/2, pad_s, pad_h);
    rect(width - side_space - pad_s, height/2 - pad_h/2, pad_s, pad_h);

    if (!stop) {
      b_x += v_x;

      if (b_x + b_s > width - pad_s - side_space) {
        b_x = width - pad_s - side_space - b_s;
        v_x *= -1;
      } else if (b_x < side_space + pad_s) {
        b_x = side_space + pad_s;
        v_x *= -1;
//        stop = true;
        t = 0;
      }
    }

    // Draw tha moving pads
    for (Pad p : pads) {
      p.draw();
      if (!stop) {
        p.update(t);
      }
    }

    // Draw the middle line
    for (int i = 1; i < 30; ++i){
        rect(width/2 - 5, i*40, 10, 20);
    }

}

void keyPressed() {
    if (key == ' ') {
      stop = !stop;
    }
}
