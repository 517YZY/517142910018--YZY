int MAX = 1000; // 最多600个粒子泡泡
int MIN_BORDER = 6; // 粒子的最小边框值
int MAX_BORDER = 10; // 粒子的最大边框值
color bjyanse= color(255, 205, 150); // 画布背景填充色
color lizi= color(0xFFFFFF); // 粒子的前景填充色
color bkyanse= color(20, 20, 20); // 粒子的边框色
ArrayList<Particle> particles; // 粒子动态数组
int[] list; // list 这里的命名不得不说，有些草率，并不能很直观的表达啥意思，其实是存储所有像素的黑白信息的
int posX, posY; // 整个代码中并没有用到，属于多余字段
PVector axis; //
PFont font; // 画面中的字体
int count; // 粒子的实际个数
String typedText = "processing";
// String typedText = "2";
//String inputText = ""; // 支持运行时进行输入文字，进行实时替换文字，输入后，回车Enter进行确认更换

void setup() {
  size(1500, 600); // 也可以指定一个较大的尺寸，用来显示文字，文字的个数不需要太多，不然可能显示不完整
  background(bjyanse); // 设置背景色
  frameRate(30); // 设置帧率为30帧/秒
  noStroke(); // 无线条模式
  noCursor(); // 不显示鼠标
  String[] fontList = PFont.list();
  printArray(fontList);

  font = createFont("Monospaced", 260); // 创建黑体字体
  textFont(font); // 设定字体
  fill(0); // 字体填充为黑色
  textAlign(CENTER, CENTER); // 设定字体的对齐模式，水平居中，垂直居中
  text(typedText, width/2, height/2 - 70); // 显示字体
  typedText = "";

  count = 0; // 粒子个数从 0 开始
  loadPixels(); // 加载像素数据
  for (int y = 0; y <= height - 1; y++) {
    for (int x = 0; x <= width - 1; x++) {
      color pb = pixels[y * width + x]; // 通过（y * width + x）得到坐标（x，y）在 pixels 数组中的索引位置，获取坐标（x，y）的像素的颜色

      // 颜色的归一化操作！！！
      // 画布背景色为 bjyanse，文字颜色是黑色，此时像素颜色的红色通道值小于5，只能是文字的黑色
      // 也就是通过 red(pb) < 5 来简单快速的判断出文字所在的像素，将这些像素在list数组中的位置的数值都标记成0-黑色
      if (red(pb) < 5) {
        list[y * width + x] = 0;
      } else {  // 背景色，都标记成1
        list[y * width + x] = 1;
      }
    }
  }
  updatePixels(); // 更新像素
  particles = new ArrayList<Particle>(); // 申请粒子动态数组
}

void draw() {
  if (count < MAX) { // 限定粒子数目不能超过最大数
    int i=0;
    // 随机3次，如果随机到的像素位置在list数组中标记为了0，也就是文字所在的像素，那么就在这个位置添加一个粒子
    while (i<3) {
      axis = new PVector(int(random(100, width - 100)), int(random(100, height - 100)));
      if (list[int(axis.y * width + axis.x)]==0) {
        particles.add(new Particle(axis.x, axis.y));
        i++;
        count++;
      }
    }
  }
  background(bjyanse); // 设定画布背景色，起到擦除重新绘制的作用
  // 第一次循环遍历，用来绘制粒子的底层边框色
  // display 用来绘制背景圆
  // update用来更新粒子的速度和位置
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    fill(bkyanse);
    p.display();
    p.update();
  }
  // 第二次循环遍历，用来绘制粒子的前景色
  // display2 用来绘制前景圆
  // update用来更新粒子的速度和位置
  for (int j = 0; j < particles.size(); j++) {
    Particle p = particles.get(j);
    fill(lizi);
    p.display2();
    p.update();
  }
}

class Particle {
  PVector location; // 粒子的位置
  PVector velocity; // 粒子的速度
  float scale; // 粒子半径的缩放系数
  int radius; // 粒子的直径大小，作者用 radius 含义为 半径，并不太准确
  int border; // 粒子背景圆的边框大小
  int incBorder; // 粒子的边框变化幅度值
  int type; // 粒子的类型，目前分为0、1两种

  Particle(float x, float y) {
    location  = new PVector(x, y);
    velocity  = new PVector(random(0.5), random(0.5));
    scale     = random(.35, .9);
    radius    = int(scale * 40);
    border    = MIN_BORDER -1;    
    incBorder = 1;
  }

  // 速度和位置的更新
  void update() {
    location.add(velocity);
    // 抖动效果的终极秘诀：始终让粒子本身在文字黑色像素抖动
    // 按照目前的速度，下一个帧循环中，当前像素的左右像素是非黑色（非文字像素）时，则将x轴速度乘以-1进行反向
    int nextLocX1 = int(location.y) * width + int(location.x + velocity.x);
    int nextLocX2 = int(location.y) * width + int(location.x - velocity.x);
    if ((list[nextLocX1] == 1)   ||   (list[nextLocX2] == 1)) {
      velocity.x *= -1;
    }
    // 按照目前的速度，下一个帧循环中，当前像素的上下像素是非黑色（非文字像素）时，则将y轴速度乘以-1进行反向
    int nextLocY1 = int(location.y + velocity.y) * width + int(location.x);
    int nextLocY2 = int(location.y - velocity.y) * width + int(location.x);
    if ((list[nextLocY1] == 1) || (list[nextLocY2] == 1)) {
      velocity.y *= -1;
    }
  }

  void display() {
      ellipse(location.x, location.y, radius + border, radius + border);
  }

  void display2() {
      ellipse(location.x, location.y, radius - border, radius - border);
  }
}
