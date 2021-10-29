ArrayList<Particle> p1=new ArrayList();
ArrayList<Particle> p2=new ArrayList();
ArrayList<Particle> p3=new ArrayList();
float alpha;

void setup() {
  size(1200, 1200);
  background(0);
  noStroke();
  for (int i = 0; i < 10000; i++) { //产生时分别在画面上中下三部分                      当然了，很简单的进行操作就可以分为更多层次和颜色的粒子
    float x = random(width);
    float y = random(height/3);
    float r = map(x, 0, height, 86, 86);
    int c = color(245,86,138);
    Particle pp=new Particle(x,y,c);
    p1.add(pp);
  }

for (int j = 0; j < 10000; j++) {   
  float x = random(width);
  float y = random(height/3,2*height/3);
  float r = map(y, 0, height,232, 232);
  int c = color(86,232,205);
  Particle pp=new Particle(x,y,c);
  p2.add(pp);
  }
  
  for (int z = 0; z < 10000; z++) {   
  float x = random(width);
  float y = random(2*height/3,height);
  float r = map(y, 0, height,223, 223);
  int c = color(250,223,86);
  Particle pp=new Particle(x,y,c);
  p3.add(pp);
  }
}

void draw() {
  frameRate(25);
  alpha = map(300, 0, width, 5, 35);
  fill(0, alpha);
  rect(0, 0, width, height);
  loadPixels();
  for (Particle pp : p1) {
    pp.move();
  }
  for (Particle pp : p2) {
    pp.move();
  }
  for (Particle pp : p3) {
    pp.move();
  }
  updatePixels();
}

class Particle {
  float posX, posY, in, theta=0;
  color  c;
  Particle(float x, float y, color c) {
    posX = x;
    posY = y;
    this.c = c;
  }
  
public void move() {
  update();
  checkEdge();
  display();
  }
  
void update() {
  in +=  0.01;
  theta = noise(posX * 0.004, posY * 0.004, in) * TWO_PI;
  posX += 1.5 * cos(theta)-cos(1.5*theta);
  posY += 1.5* sin(theta)-sin(1.5*theta);
  }
  
void display() {
  if (posX > 0 && posX < width && posY > 0  && posY < height) {
    pixels[(int)posX + (int)posY * width] =  this.c;
  }
}
  
void checkEdge() {
  if (posX < 0) posX = width;
  if (posX > width ) posX =  0;
  if (posY < 0 ) posY = height;
  if (posY > height) posY =  0;
  }
}
