PFont myFont;
int p;
float x=8;
boolean a=false;
boolean b=false;
boolean c=false;
boolean d=false;
boolean e=false;
boolean f=false;
boolean g=false;
boolean h=false;
boolean i=false;
boolean j=false;
boolean z=false;
//------------------------------------------------------定义-------------------------------------
int [] colors ={#FFFFFF,#F0181C,#EEB041,#F2FA23,#87FA23,#23FAF4,#1683F5,#162AF5,#7B36EA,#6C6C6C};
int pcol=0;

/*
color w=#FFFFFF;//white
color re=#F0181C;//red
color or=#EEB041;//orange
color cy=#F2FA23;//Cyan
color fl=#87FA23;//fluorescentyello
color wa=#23FAF4;//Wathet
color bl=#1683F5;//Deep Blue
color pu=#162AF5;//purplish blue 
color pur=#7B36EA;//purple
color gr=#6C6C6C;//gray
*/
//------------------------------------------------------背景-------------------------------------
void setup(){
  size(1600,850);
  background(#000302);
}
//-------------------------------------------------------------------------------------------
void draw(){
  strokeWeight(0.5);
  stroke(colors[0]);//框
  strokeWeight(0.5);
  line(60,0,60,850);
  
  //------------------------------------------------------eraser-------------------------------------
  myFont=createFont("Arial",24);
  String s1="Delete";
  String s2="Style";
  String s3="A";
  String s4="B";
  String s5="C";
  String s6="SAVE";
  String s7="S";
  textSize(20);
  text(s1,3,52);
  text(s2,7,720);
  text(s3,45,607);
  text(s4,45,647);
  text(s5,45,687);
  text(s6,8,825);
  text(s7,45,793);
  
//-------------------------------------------------------------------------------------------    
  if(key=='a'){
    p=1;
  }
  if(key=='b'){
    p=2; 
  }  
  if(key=='c'){
    p=3;

  }
  if(p==2){
    pen1();
  }    
  if(p==3){
    pen2();
  }  
  if(p==1){
    pen3();
  }

// ------------------------------------------------------save img-------------------------------
    if(key=='s'){
      save("canvas.jpg");
    } 

//------------------------------------------------------颜色框-------------------------------------  
  fill(#D3D3D3);
  rect(10,5,30,30);
   fill(colors[1]);
  rect(10,80,30,30);
   fill(colors[2]);
  rect(10,120,30,30);
   fill(colors[3]);
  rect(10,160,30,30);
  fill(colors[4]);
  rect(10,200,30,30);
    fill(colors[5]);
  rect(10,240,30,30);
    fill(colors[6]);
  rect(10,280,30,30);
    fill(colors[7]);
  rect(10,320,30,30);
    fill(colors[8]);
  rect(10,360,30,30);
    fill(colors[9]);
  rect(10,400,30,30);
    fill(colors[0]);
  rect(10,440,30,30);
  
//------------------------------------------------------mode------------------------------------ 
   fill(#FF8503);
  ellipse(25,640,32,32);
   fill(#D3D3D3);
  ellipse(25,640,27,27);
   fill(#FF8503);
   quad(25,664,9,680,25,696,41,680);
   fill(#D3D3D3);
   ellipse(25,680,21,21);
   fill(#D3D3D3);
   noStroke();
  ellipse(25,600,30,30);
   
   fill(#FF8503);
  rect(11,770,32,32);
   fill(#D3D3D3);
  rect(13,772,28,28);

//-------------------------------------------------------------------------------------------
   no1();
   no2();
   no3();
   no4();
   no5();
   no6();
   no7();
   no8();
   no9();
   no10();  
   last();

//------------------------------------------------------画笔-------------------------------------

if(a==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[1]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(b==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[2]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(c==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[3]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(d==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[4]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(e==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[5]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(f==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[6]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(g==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[7]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(h==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[8]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(i==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[9]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}

if(j==true){
  if(mousePressed){
    if(mouseX>60){
fill(colors[0]);
noStroke();
ellipse(mouseX,mouseY,10,10);
  }
}
}
//------------------------------------------------------删除-------------------------------------
if(z==true){
  noStroke();
 fill(0);
 rect(62,0,1600,900);//可以做多个方形盖住
}
}

//------------------------------------------------------选择颜色-------------------------------------

void no1() {
 if(mouseX<40&&mouseX>10&&(mouseY>80&&mouseY<110)){
 if(mousePressed==true)
 a=true;
 b=c=d=e=f=g=h=i=j=z=false;
  }
}
void no2() {
 if(mouseX<40&&mouseX>10&&mouseY>120&&mouseY<150){
 if(mousePressed==true)
 b=true;
 a=c=d=e=f=g=h=i=j=z=false;
 }
}
void no3() {
 if(mouseX<40&&mouseX>10&&mouseY>160&&mouseY<190){
 if(mousePressed==true)
c=true;
a=b=d=e=f=g=h=i=j=z=false;
 }
}
void no4() {
 if(mouseX<40&&mouseX>10&&mouseY>200&&mouseY<230){
 if(mousePressed==true)
d=true;
a=b=c=e=f=g=h=i=j=z=false;
 }}
 
void no5() {
 if(mouseX<40&&mouseX>10&&mouseY>240&&mouseY<270){
 if(mousePressed==true)
e=true;
a=b=c=d=f=g=h=i=j=z=false;
 }}
 
 void no6() {
 if(mouseX<40&&mouseX>10&&mouseY>280&&mouseY<310){
 if(mousePressed==true)
f=true;
a=b=c=d=e=g=h=i=j=z=false;
 }}
 
void no7() {
 if(mouseX<40&&mouseX>10&&mouseY>320&&mouseY<350){
 if(mousePressed==true)
g=true;
a=b=c=d=e=f=h=i=j=z=false;
 }}
 
void no8() {
 if(mouseX<40&&mouseX>10&&mouseY>360&&mouseY<390){
 if(mousePressed==true)
h=true;
a=b=c=d=e=f=g=i=j=z=false;
 }}
 
 void no9() {
 if(mouseX<40&&mouseX>10&&mouseY>400&&mouseY<430){
 if(mousePressed==true)
i=true;
a=b=c=d=e=f=g=h=j=z=false;
 }}

 void no10() {
 if(mouseX<40&&mouseX>10&&mouseY>440&&mouseY<470){
 if(mousePressed==true)
j=true;
a=b=c=d=e=f=g=h=i=z=false;
 }}
//------------------------------------------------------删除键-------------------------------------
void last() {
 if(mouseX<40&&mouseX>10&&mouseY>5&&mouseY<45){
 if(mousePressed==true)
z=true;
a=b=c=d=f=g=h=i=e=false;
 }
}
//-------------------------------------------------------------------------------
void pen1(){
  if(mousePressed){
     if(mouseX>60){
    stroke(colors[0]);
    strokeWeight(2);
    fill(colors[pcol]);
    ellipse(mouseX,mouseY,x*1.3,x*1.3);
  }
}
}

void spark(){
  quad(mouseX,mouseY-x*1.2,mouseX-x*1.2,mouseY,mouseX,mouseY+x*1.2,mouseX+x*1.2,mouseY);
}

void pen2(){
    if(mousePressed){
       if(mouseX>60){
    noStroke();
    fill(colors[pcol]);
    spark();
  }
}
}

void pen3(){
  if(mousePressed){
     if(mouseX>60){
    noStroke();
    fill(colors[pcol]);
    ellipse(mouseX,mouseY,0,0);
}
}
}
