int Width = 800;
int Height = 800;
int c=0;
int r=0;
float rSize = 0;
float cSize = 0;
float x = c+cSize;
float y = r+rSize;
color[] colors = {#ffffff, #AAA8A0, #000000};

void setup() {
  size(800,800);
  background(#ffffff);
  YZY(); 
}

void draw() {
  if (mousePressed){
        YZY();
     }
}

void YZY() {
  for(int c = 0; c<Width; c+=cSize) {
  cSize = random(8, Height/3);
    for(int r = 0; r<Height; r+=rSize ) {
    rSize = random(8, Width/3);
      stroke(#000000);
      strokeWeight(6);
      line(0, y, Width, y);
      line(x, r, x, y);
      color rect= colors[int(random(colors.length))];
      fill(rect);
      rect(c, r, cSize, rSize);
     }
  }
}
