
/*
import gifAnimation.*;
GifMaker gifExport;
*/
void setup() {
  size(800, 800);
  /*
  gifExport = new GifMaker(this,"export.gif");
  gifExport.setRepeat(0); // = 永远循环
  */
  }

void draw() {
  background(0);
  translate(width/2, height/2);
  recursion(200, 0);
  noCursor(); 
  /* 
  if (frameCount%2==0 &&  frameCount<500) {
  gifExport.setDelay(10);  //动画 GIF 的速度
  gifExport.addFrame();
  }
  if (frameCount>500) gifExport.finish();
  */
  }

void recursion(float r, int num) {
  if (r > 15) {
    if (r > 20) {
    noFill();
    stroke(255);
    } else {
      fill(0);
      }
//-------------------------------------------------------------------------------------------------------------
float ratio = mouseX/(float)width;
  if (ratio > 0.7) {
    ratio = 0.7;
    }
    r = r * ratio;
    num ++;
//-----------------------------------------------------------------------四边形--------------------------------
    rectMode(CENTER);
    rect(0, 0, r * 2, r * 2);

    pushMatrix();
    rotate(millis()/2000.0 * num);
    translate(-r, -r);
    recursion(r, num);
     popMatrix();

    pushMatrix();
    rotate(millis()/2000.0 * num);
    translate(-r, r);
    recursion(r, num);
    popMatrix();

    pushMatrix();
    rotate(millis()/2000.0 * num);
    translate(r, -r);
    recursion(r, num);
    popMatrix();

    pushMatrix();
    rotate(millis()/2000.0 * num);
    translate(r, r);
    recursion(r, num);
    popMatrix();
  }
}
