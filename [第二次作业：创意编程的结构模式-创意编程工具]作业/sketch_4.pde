void setup()
{
  size(800,800);
  background(255);
}
void draw()
{
  for(int i=0;i<100;i++)//i=0只执行一次，执行for循环的条件，每执行一次i++
  {
    rect(2*i,4*i,200,200);
    fill(2*i);
  }
  
 // fill(255);
 // rect(259,287,200,200);
}
//for循环放在setup里面也可以呈现一样的
