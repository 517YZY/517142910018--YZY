import gifAnimation.*;
GifMaker gifExport;

void setup(){
  fullScreen();
  gifExport = new GifMaker(this,"export.gif");
  gifExport.setRepeat(0); // = 永远循环
}

void draw(){
  background(0);
  pos spos = new pos();
  spos.x = width / 2;
  spos.y = height / 2;
  spos.angle = HALF_PI * 3;
  spos.len = height / 3;
  Tree(spos, 22);
  
  if (frameCount%2==0 &&  frameCount<500) {
  gifExport.setDelay(10);  //动画 GIF 的速度
  gifExport.addFrame();
  }
  if (frameCount>500) gifExport.finish();
}

void Tree(pos p1, int t){
  if(t > 0){
    float branch = frameCount * 0.02;
    pos p2 = new pos();
    p2.x = p1.x + cos(p1.angle) * p1.len;
    p2.y = p1.y + sin(p1.angle) * p1.len;
    pos p3 = new pos();
    p3.x = p2.x + cos(p1.angle + branch) * p1.len;
    p3.y = p2.y + sin(p1.angle + branch) * p1.len;
    pos p4 = new pos();
    p4.x = p2.x + cos(p1.angle - branch) * p1.len;
    p4.y = p2.y + sin(p1.angle - branch) * p1.len;

    stroke(255);
    strokeWeight(1.5);
    fill(random(0,235),random(100,235),random(100,235));
    bezier(p1.x, p1.y, p2.x, p2.y, p2.x, p2.y, p3.x, p3.y);
    bezier(p1.x, p1.y, p2.x, p2.y, p2.x, p2.y, p4.x, p4.y);
    pos rpos = new pos();
    rpos.x = p3.x;
    rpos.y = p3.y;
    rpos.len = p1.len / 1.4;
    rpos.angle = p1.angle + branch;
    Tree(rpos, t -2);
    pos lpos = new pos();
    lpos.x = p4.x;
    lpos.y = p4.y;
    lpos.len = p1.len / 1.4;
    lpos.angle = p1.angle - branch;
    Tree(lpos, t -2);
  }
}

class pos{
  float x, y;
  float angle;
  float len;
  pos(){
    x = 0;
    y = 0;
  }
}
