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
![效果展示](https://user-images.githubusercontent.com/90589652/138054151-bc9fc88a-febf-49ee-9823-939033335e83.jpg)

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
![程序效果图](https://github.com/517YZY/Processing-Homework/blob/main/%E7%AC%AC%204%20%E5%91%A8/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202021-10-16%20194721.jpg)

