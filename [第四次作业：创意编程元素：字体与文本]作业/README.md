第四次：
本次作业共三个程序代码，效果分别为：文本附着曲线、文本自由活动、文本绕点旋转。
sketch_1:文本附着曲线
sketch_2:文本自由活动
sketch_3：文本绕点旋转

sketch_1:
程序运行效果为：文本体现在曲线上。
重点： 
通过定义text and circle，它们都要在中心点上：
" textAlign(CENTER) "and" translate(width / 2, height / 2)" 
考虑到整体中各文本之间的距离不一致且距离不合适，所以要以每个文字的距离为准：
" char currentChar = message.charAt(i) ; float w = textWidth(currentChar) " rotate：" rotate(theta+PI/2) "
![效果展示](https://user-images.githubusercontent.com/90589652/138054383-25bfb62a-15f2-4555-adf7-9c564c93e208.jpg)

sketch_2:
重点1：创造一个与字符串同样大小的数组，并定义text初始位置 letters = new Letter[message.length()]; int x = 16; for (int i = 0; i < message.length(); i++) { letters[i] = new Letter(x,100,message.charAt(i)); x += textWidth(message.charAt(i)); } }
重点2：利用mousePressed，shake,home达到点击text会随机运动，不点击回复原位的效果 if (mousePressed) { letters[i].shake(); } else { letters[i].home();
void shake() { ； void home() {
重点3：利用class类，描述每一个独立的文字 class Letter { char letter; float homex,homey; float x,y;

![21](https://user-images.githubusercontent.com/90589652/141455678-d46e8d2e-9f32-4b8d-aacf-4fd49500fd60.gif)

sketch_3:
运用了rotate使输入的文本绕某点旋转：
PFont f;      //declare
String message = "How can I pray for time to go backs.";
float theta;
void setup() {
  size(800, 800);
  f = createFont("Arial",40,true);      //create Font
}
void draw() {
  background(0);
  fill(255);
  
  textFont(f);                  // set the font
  translate(width/2,height/2);  //translate to the center
  rotate(theta);                // theta == radian 
  textAlign(CENTER);
  text(message,0,0);
  theta += 0.01;                // increase rotation
}

![31](https://user-images.githubusercontent.com/90589652/141455710-dcdbf6c4-ebe6-422c-98e6-57d5b015d54c.gif)

sketch_4:
利用程序将白色泡泡限定在黑框中，并且显示出动态的文字。利用：
location.add(velocity);
    int nextLocX1=int(location.y) * width + int(location.x + velocity.x);
    int nextLocX2=int(location.y) * width + int(location.x - velocity.x);
    if ((list[nextLocX1]== 1)||(list[nextLocX2]== 1)) {
     velocity.x *= -1;
来将泡泡围绕限定范围动起来。
![2](https://user-images.githubusercontent.com/90589652/141137394-a9620d91-e31f-4de1-9377-d29c11461f47.gif)

