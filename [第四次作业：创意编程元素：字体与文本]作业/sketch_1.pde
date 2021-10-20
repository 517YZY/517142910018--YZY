String message = "Why I have never catched the happiness? Whenever I want you ,I will be accompanyed by the memory of.";
PFont f;//declare
float r=300;//the circle radius

void setup() {
  size(800, 800);
  f = createFont("Georgia",35,true);
  textFont(f);
  textAlign(CENTER);//let the text on the center
  smooth();
}

void draw() {
  background(255);
  translate(width/2, height/2);//draw the circle in the center
  noFill();
  stroke(0);
  ellipse(0,0,r*2,r*2);
  float arclength = 0;//弧长

   for (int i = 0; i < message.length(); i++)
  {
    char currentChar = message.charAt(i);
    float w = textWidth(currentChar);//the width of each character
    arclength += w/2;
 
    float theta = PI + arclength / r;

    pushMatrix();
    translate(r*cos(theta), r*sin(theta)); // polar to cartesian coordinate conversion
    rotate(theta+PI/2);    //rotate the box
   
    fill(0); // display the character
    text(currentChar,0,0);
    popMatrix();
       arclength += w/2; //move halfway again
  }
}
