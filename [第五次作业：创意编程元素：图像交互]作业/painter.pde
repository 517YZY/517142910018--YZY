import controlP5.*;
ControlP5 cp5;

int c = color(100);

boolean Painter[]=new boolean[5];

RadioButton brush;
int size=10;
int sliderValue = 10;
Slider abc;
void setup() {
  size(1200, 1000);
  cp5 = new ControlP5( this );
  cp5.addColorWheel("c", 10, 10, 200 ).setRGB(color(128, 0, 255));
  noStroke();
  background(255);
  rectMode(CENTER);

  brush=cp5.addRadioButton("radioButton")
    .setPosition(250,10)
    .setSize(80, 40)
    .addItem("ellipse", 0)
    .addItem("Ink", 1)
    .addItem("Watercolor", 2)
    .addItem("eraser", 3)
    ;

  cp5.addSlider("sliderValue")
    .setPosition(400,10)
    .setRange(1, 200)
    .setSize(100, 40)
    ;
}

void draw() {
  noStroke();
  fill(0);
  rect(width/2,125,width,250);

  size=sliderValue;
  if (mousePressed)
  {
    if (Painter[0])
    {
      brush1();
    } else if (Painter[1])
    {
      brush2();
    } else if (Painter[2])
    {
      brush3();
    } else if (Painter[3])
    {
      brush4();
    }
  }
}


void brush0()
{
  noStroke();
  fill( c );
  rect(mouseX, mouseY, size, size);
}
void brush1()
{
  noStroke();
  fill( c );
  ellipse(mouseX, mouseY, size, size);
}

void brush2()
{
  float weight=map(dist(mouseX, mouseY, pmouseX, pmouseY), 0, 100, 0, 20);
  strokeWeight(weight);
  stroke(c);
  line(pmouseX, pmouseY, mouseX, mouseY);
}

void brush3()
{
  noStroke();
  for (int i=0; i<size; i++)
  {
    float angle=random(TWO_PI);
    float R=random(size);
    float sizex=random(5, 10);
    fill(0);
    ellipse(mouseX+R*cos(angle), mouseY+R*sin(angle), sizex, sizex);
  }
}

void brush4()
{
  fill(255);
  ellipse(mouseX, mouseY, size, size);
}


void controlEvent(ControlEvent theEvent) {


  if (theEvent.isFrom(brush)) {
    for (int i=0; i< Painter.length; i++)
    {
      Painter[i]=false;
    }
    Painter[int(theEvent.getGroup().getValue())]=true;
  }
}