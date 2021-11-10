int MAX = 1000; // 最多1000泡泡
int MIN_biankuang = 6; // 最小边框
int MAX_biankuang = 10; // 最大边框

color bjys= color(255, 220, 150); // 背景色
color qjys= color(0xFFFFFF); // 前景色
color bkys= color(20, 20, 20); // 边框色

ArrayList<Particle> particles; 
int[] list; 
PVector ax; 
PFont font; // 画面中的字体
int count; // 粒子个数
String typedText = "processing";

/*
import gifAnimation.*;
GifMaker gifExport;
*/
//-------------------------------------------------------------------------------------------------------------------
void setup() {
  size(1500, 600); 
  background(bjys); 
  frameRate(30); 
  noStroke();
  noCursor(); // 不显示鼠标
  
  String[] fontList = PFont.list();
  printArray(fontList);

  font = createFont("Monospaced", 270); 
  textFont(font); 
  fill(0); 
  textAlign(CENTER, CENTER); // 字体居中模式
  text(typedText, width/2, height/2-80); // 显示字体
  typedText = "";

  count = 0; // 粒子个数从 0 开始
  list = new int[width*height];

  loadPixels(); // 加载像素数据
  for (int y = 0; y <= height - 1; y++) {
    for (int x = 0; x <= width - 1; x++) {
      color pb = pixels[y * width + x];//此是为了得到xy的索引位置，获取像素颜色

      if (red(pb) < 5) {   //判断文字所在像素，并且都变成0黑色
        list[y * width + x] = 0;
      } else {  
        list[y * width + x] = 1;// 背景色都标记成1
      }
    }
  }
  updatePixels(); // 更新像素
  particles = new ArrayList<Particle>(); // 粒子动态数组
/*
  gifExport = new GifMaker(this,"export.gif");
  gifExport.setRepeat(0); // = 永远循环
  */
}

//------------------------------------------------------------------------------------------------------------------
void draw() {
  background(bjys); 
  if (count < MAX) { 
    int i=0;
    while (i<5) {
      ax = new PVector(int(random(100, width - 100)), int(random(100, height - 100)));  //增添新粒子
      if (list[int(ax.y * width + ax.x)]==0) {
        particles.add(new Particle(ax.x, ax.y));
        i++;
        count++;
      }
    }
  }
  
//-----------------------------------------这是为了让粒子内部只画圆形，不显示黑框----------------------------------
//-------------------------------------------------------边框--------------------------------------------------------
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    fill(bkys);
    p.display();
    p.update();
  }

//-------------------------------------------------------内圆--------------------------------------------------------
  for (int j = 0; j < particles.size(); j++) {
    Particle p = particles.get(j);
    fill(qjys);
    p.display2();
    p.update();
  }
/* 
  if (frameCount%2==0 &&  frameCount<500) {
  gifExport.setDelay(10);  //动画 GIF 的速度
  gifExport.addFrame();
  }
  if (frameCount>500) gifExport.finish();
  */
}

//-------------------------------------------------------------------------------------------------------------------
class Particle {
  PVector location; // 粒子位置
  PVector velocity; // 粒子速度
  float scale; // 缩放
  int radius; 
  int biankuang; 
  int incbiankuang; // 边框变化幅度

  Particle(float x, float y) {
    location  = new PVector(x, y);
    velocity  = new PVector(random(1), random(1));
    scale= random(0.25,1);
    radius = int(scale * 40);
    biankuang = MIN_biankuang + 1;    
    incbiankuang = 1;
  }
//-------------------------------------------------------------------------------------------------------------------
  void update() {
    location.add(velocity);
    int nextLocX1=int(location.y) * width + int(location.x + velocity.x);
    int nextLocX2=int(location.y) * width + int(location.x - velocity.x);
    if ((list[nextLocX1]== 1)||(list[nextLocX2]== 1)) {
     velocity.x *= -1;//-1是为了将上一帧循环的抖动的粒子进行反向运动处理
    }
    int nextLocY1 = int(location.y + velocity.y) * width + int(location.x);
    int nextLocY2 = int(location.y - velocity.y) * width + int(location.x);
    if ((list[nextLocY1] == 1) || (list[nextLocY2] == 1)) {
     velocity.y *= -1;//-1是为了将上一帧循环的抖动的粒子进行反向运动处理
    }
  }
//------------------------------------------------------------泡泡-------------------------------------------------------
  void display() {
      ellipse(location.x, location.y, radius + biankuang, radius + biankuang);
  }

  void display2() {
      ellipse(location.x, location.y, radius - biankuang, radius - biankuang);
  }
}
