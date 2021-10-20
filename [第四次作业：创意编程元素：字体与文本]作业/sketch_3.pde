PFont f;//declare
String message = "How can I pray for time to go backs.";
float theta;

void setup() {
  size(800, 800);
  f = createFont("Arial",40,true);//create Font
}

void draw() {
  background(0);
  fill(255);
  textFont(f);                  // set the font
  translate(width/2,height/2);  //tTranslate to the center
  rotate(theta);                // theta == radian 
  textAlign(CENTER);
  text(message,0,0);
  theta += 0.01;                // increase rotation
}
