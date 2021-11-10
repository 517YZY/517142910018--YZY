float t=0;
void setup(){
 size(600,600);
 frameRate(1);
}
void draw(){
 background(255) ;
 for (int i=0;i<width;i+=6){
 stroke(0);
 strokeWeight(3);
// line(i,0,i,random(0,height));
 line(i,0,i,height*noise(t));
 t+=0.02;//t的变化越小，图形就越平滑，趋向平行
 }

 }



//noise()函数
//1.noise(x)线性
//2.noise（x，y）平面
//3.noise（x,y,z）立体
//以noise（t）为例，是一个介于0~1之间的数值
//是一个随机值，但是是连续的，（伪随机）
