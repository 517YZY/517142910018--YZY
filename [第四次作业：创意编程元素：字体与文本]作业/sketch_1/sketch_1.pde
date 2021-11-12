PFont f;
String message = "click mouse here,it's fun,right?";
Letter[] letters;

void setup() {
  size(900,500);
  f = createFont("Arial",60,true);
  textFont(f);
  letters = new Letter[message.length()];//create the array the same size as the String
  int x = 16;
  for (int i = 0; i < message.length(); i++) {
    letters[i] = new Letter(x+50,250,message.charAt(i));
    x += textWidth(message.charAt(i));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < letters.length; i++) {
    letters[i].display();

    if (mousePressed) {  // if the mouse is pressed the letters shake
    // if not, they return to their original location
      letters[i].shake();
    } else {
      letters[i].home();
    }
  }
}


class Letter {    // describe a single Letter
  char letter;
  float homex,homey; //  knows its original location and current location
  float x,y;

  Letter (float x_, float y_, char letter_) {
    homex = x = x_;
    homey = y = y_;
    letter = letter_;
  }

  void display() {
    fill(255);
    textAlign(LEFT);
    text(letter,x,y);
  }

  void shake() {     //randomly
    x += random(-3,3);
    y += random(-3,3);
  }

  void home() {    //return the letter home
    x = homex;
    y = homey;
  }
}
