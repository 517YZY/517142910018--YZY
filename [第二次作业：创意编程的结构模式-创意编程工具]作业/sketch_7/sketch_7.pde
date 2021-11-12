int i=0;
void setup()
{
  size(400,400);
  background(255);
  }
  void draw()
  {
     while (i<80) 
     {
     stroke(255,0,0);
     strokeWeight(3);
     line(30,5*i,30+2*i,5*i);//x1,y1,x2,y2
     i++;
     }
  }
   
  
  //for循环：今天做十套试卷
  //while循环：今天做试卷直到出现100分为止
