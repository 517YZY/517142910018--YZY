int num =800;
Y[]yuans = new Y[num];//类名[]对象数组名 = new 类名[数组的大小];


void setup(){
  fullScreen();//满屏
// size(600,600); 
 for (int i=0;i<num;i++){
  yuans[i]=new Y(random(0,width),random(0,height),random(0,80)); 
 }
}

//———画画中要执行类，将函数放在这里update、display————
void draw(){
  background(0);
  for (int i=0;i<num;i++){
  yuans[i].update();
  yuans[i].display();
  }
  
  for(int i=0;i<num;i++){
   for(int j=i+1;j<num;j++){
     if(dist(yuans[i].x,yuans[i].y,yuans[j].x,yuans[j].y)<100)
     //第一个值的横纵坐标和第二个值的横纵坐标的长度<100
     {
       stroke(255,0,0);
       strokeWeight(0.8);
     // strokeWeight(8-dist(yuans[i].x,yuans[i].y,yuans[j].x,yuans[j].y)*0.1);
       
       line(yuans[i].x,yuans[i].y,yuans[j].x,yuans[j].y);
       }
   }
  }
 }    
    
    
    
  //————————class函数——————————————
class Y
{
 float x,y,r;//x坐标，y坐标，r直径
 Y(float x,float y,float r)//构造函数，初始化
 {
   this.x=x;
   this.y=y;
   this.r=r;
 }
  void update()//用来更新位置等变量
  {
  x+=random(-2,2);
  y+=random(-2,2);
  r+=random(-2,2);
  }
  void display()//用来画画
  {
   fill(255);
   ellipse(x,y,r,r);
  }
}
