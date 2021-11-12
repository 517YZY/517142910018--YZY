/*1111
void setup()
{
  size(600,600);
}
void draw()
{
 // background(#e59f8a);没有背景的时候，跟着鼠标动的矩形
 //会保留住，形成一个不会消失的轨迹
 //或者将background放在setup程序里
 //个人认为：因为放在draw中每次都会与重新制作背景，盖掉了运行轨迹
  
  fill(243);
  //rect(171,129,226,323);
 // mouseX,mouseY跟着鼠标在动
  rect(mouseX,mouseY,200,200);
}
*/


void setup()
{
  size(600,600);
}
void draw()
{
 // background(#e59f8a);
  background(mouseX/5,mouseY/5,1000);///5颜色变化范围会小
  fill(243);
  //rect(171,129,226,323);
 // mouseX,mouseY跟着鼠标在动
  rect(mouseX,mouseY,200,200);
}
