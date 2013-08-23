// Screen size
float swidth = 1920;
float sheight = 1080;

// Ball velocity
float v_x = 18;
// Ball width and height
float b_s = 20;
// Space between the borders and the goalies
float side_space = 80;
// Pad width
float pad_s = 20;
// Pad Height
float pad_h = 80;
// Initial ball position
float b_x = side_space + pad_s;

// X position for the left players's lines
// Right players are equal plus 900px

float pad1_x = 220;
float pad2_x = 400;
float pad3_x = 600;
float pad4_x = 800;

// Frequency of the pads
float pad1_w = PI/((swidth - 2*side_space - 2*pad_s - 10)/v_x);

// The 20 players pads
ArrayList<Pad> pads = new ArrayList<Pad>();

float t = 0;
float dt = 1;

boolean stop = true;

void setup () {
  size(int(swidth), int(sheight));

  // Left team

  pads.add(new Pad(pad_h, pad_s, pad1_x,  sheight/2  - 3*pad_h/2 - 192, pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad1_x, sheight/2  + 3*pad_h/2 - 192, pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad1_x, sheight/2  + 9*pad_h/2 - 192, pad1_w, (sheight/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad2_x,  sheight/2  - 2*pad_h/2 - 192, -pad1_w, (sheight/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad2_x, sheight/2  + 6*pad_h/2 - 192, -pad1_w, (sheight/6), pad2_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad3_x,  sheight/2  - 3*pad_h/2 - 162, pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad3_x, sheight/2  + 3*pad_h/2 - 162, pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad3_x, sheight/2  + 9*pad_h/2 - 162, pad1_w, (sheight/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, pad4_x,  sheight/2  -2*pad_h/2 - 192, -pad1_w, (sheight/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, pad4_x, sheight/2  + 4*pad_h/2 - 192, -pad1_w, (sheight/6), pad2_x/abs(v_x)));

  // Right team

  pads.add(new Pad(pad_h, pad_s, 900 +  pad1_x,  sheight/2  - 3*pad_h/2 - 202, -pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad1_x, sheight/2  + 3*pad_h/2 - 182, -pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad1_x, sheight/2  + 9*pad_h/2 - 168, -pad1_w, (sheight/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, 900 +  pad2_x,  sheight/2  - 2*pad_h/2 - 195, pad1_w, (sheight/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad2_x, sheight/2  + 6*pad_h/2 - 165, pad1_w, (sheight/6), pad2_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, 900 +  pad3_x,  sheight/2  - 3*pad_h/2 - 157, -pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad3_x, sheight/2  + 3*pad_h/2 - 125, -pad1_w, (sheight/6), pad1_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad3_x, sheight/2  + 9*pad_h/2 - 125, -pad1_w, (sheight/6), pad1_x/abs(v_x)));

  pads.add(new Pad(pad_h, pad_s, 900 +  pad4_x,  sheight/2  -2*pad_h/2 - 192, pad1_w, (sheight/6), pad2_x/abs(v_x)));
  pads.add(new Pad(pad_h, pad_s, 900 +  pad4_x, sheight/2  + 4*pad_h/2 - 192, pad1_w, (sheight/6), pad2_x/abs(v_x)));

}

void draw () {
  if (!stop)
    t += dt;

  background(color(2, 152, 52));
  fill(255);
  noStroke();

  // Text for debug purposes
  // textSize(25);
  // text(b_x + "  " + pads.get(0).y, swidth/2, 100);

  // Draw ball
  rect(b_x, height/2.0 - b_s/2.0, b_s, b_s);

  // Draw goalies
  rect(side_space, sheight/2 - pad_h/2, pad_s, pad_h);
  rect(swidth - side_space - pad_s, sheight/2 - pad_h/2, pad_s, pad_h);

  if (!stop) {
    b_x += v_x;

    if (b_x + b_s > swidth - pad_s - side_space) {
      b_x = swidth - pad_s - side_space - b_s;
      v_x *= -1;
    } else if (b_x < side_space + pad_s) {
      b_x = side_space + pad_s;
      v_x *= -1;
      //        stop = true;
      t = 0;
    }
  }

  // Draw moving pads
  for (Pad p : pads) {
    p.draw();
    if (!stop) {
      p.update(t);
    }
  }

  // Draw middle line
  for (int i = 1; i < 30; ++i){
    rect(swidth/2 - 5, i*40, 10, 20);
  }

}

void keyPressed() {
  if (key == ' ') {
    stop = !stop;
  }
}
