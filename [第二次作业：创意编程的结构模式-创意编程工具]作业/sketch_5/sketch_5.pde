void setup()
{
  size(600,600);
  background(255);
}
void draw()
{
  //嵌套for循环
  for(int i=0;i<147;i++)//列
  {
    for(int j=0;j<99;j++)//行
    {
      fill(3*i,12*j,0.5*i*j);
      rect(24*i,23*j,17,16);
    }  
  }
  }
