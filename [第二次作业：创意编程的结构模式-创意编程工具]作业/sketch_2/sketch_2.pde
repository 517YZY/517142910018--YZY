//
int c=0;//整数类型
//float//浮点数，小数
//boolean//布尔数 ture,false


void setup()
{
  size(300,300);
  frameRate(5);
}
void draw()
{
  c++;
  background(c);
  fill(random(0,255),random(0,255),random(0,255));
  strokeWeight(5);
  stroke(random(0,255),random(0,255),random(0,255));
  rect(random(0,255),random(0,255),20,20);
  
}
