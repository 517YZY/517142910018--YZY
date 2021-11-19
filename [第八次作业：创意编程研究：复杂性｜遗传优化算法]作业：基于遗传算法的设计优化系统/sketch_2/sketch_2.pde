void setup() {
  size(1200, 800);
  b  = new BirdPopulation(500);
  pipes.add(new Pipe(random(100, 500)));
}

//------------------------------------------------------------------------------------------------------
void draw() {
  for (int c = 0; c < 5; c ++) {
    background(75, 175, 255);
    b.update();
    for (int i = pipes.size() - 1; i >= 0; i --) {
      pipes.get(i).update();
      if (!pipes.get(i).onScreen) {
        pipes.remove(i);
        for (Bird bird : b.birds) {
          if (!bird.dead) {
            bird.score ++;
          }
        }
      }
    }

    if (b.allDead()) {
      b.calcFitness();
      b.naturalSelection();
      b.mutate();
      resetGame();
    }

    if (counter % 100 == 0)
      pipes.add(new Pipe(random(100, 500)));
      
    counter ++;
    fill(255);
    textSize(32);
    text("Gen: " + b.gen, 20, 50);

    textSize(32);
    text("High Score: " + hiScore, 150,50);
  }
}

//--------------------------------------------------------------------------------------------------
class Bird {
  float y;
  float x = 64.0;
  float vel = -10;
  float acc = .6;
  boolean dead = false;
  NeuralNet brain;
  float fitness;
  float score = 0;
  boolean best = false;

  Bird() {
    y = height/2;
    brain = new NeuralNet(5, 8, 1);
  }

  Bird(NeuralNet brain) {
    y = height/2;
    this.brain = brain;
  }

  void goUp(ArrayList<Pipe> pipes) {
    Pipe closest = pipes.get(0);
    for (Pipe p : pipes) {
      if (closest.x > p.x && p.x - 50 > x) {
        closest = p;
      }
    }

    float[][] inputs = {{(closest.x - x)/width}, {y/height}, {vel/10}, {closest.top/height}, {closest.spacing/height}};
    Matrix out = brain.feedforward(new Matrix(1, 1).fromArray(inputs));
    if (out.table[0][0] > .5)
      vel = -8;
  }

  void kill(Pipe p) {
    if (x > p.x && x < p.x + 50) {
      if (y < p.top || y > p.top + p.spacing) {
        dead = true;
      }
    }
  }

  void calcFitness() {
    fitness = (score > 0) ? 10*score*score + counter/100: 0.0001;
  }

  void show(boolean isBest) {
    fill(255, 0, 0);
    triangle(x + 10, y - 10, x + 10, y + 10, x + 20, y);
    if (isBest) {
      fill(0, 255, 0);
      noStroke();
      ellipse(x, y, 25, 25);
      fill(255, 255, 0);
      ellipse(x, y, 15, 15);
    } else {
      fill(255, 255, 0, 150);
      noStroke();
      ellipse(x, y, 25, 25);
    }
  }

  void update(boolean isBest) {
    if (!dead) {
      vel += acc;
      y += vel;
      dead = y > height - 25 || y < 25;
      show(isBest);
      goUp(pipes);
      for (Pipe p : pipes)
        kill(p);
    } 
    else {
    }
  }
}
//----------------------------------------------------------------------------------------------------------------
class BirdPopulation {
  ArrayList<Bird> birds;
  Bird best;
  int gen = 1;
  BirdPopulation(int num) {
    birds = new ArrayList();
    for (int i = 0; i < num; i ++) {
      birds.add(new Bird());
    }
  }

  void update() {
    for (Bird b : birds) {
      b.update(b.best);
      hiScore = max(int(b.score), hiScore); //<>//
    }
  }

  boolean allDead() {
    for (Bird b : birds) {
      if (!b.dead)
        return false;
    }
    return true;
  }

  void calcFitness() {
    Bird best = null;
    float total = 0;
    float totalScore = 0;
    for (Bird bird : birds) {
      bird.calcFitness();
      total += bird.fitness;
      totalScore += bird.score;
      if (best == null || bird.fitness > best.fitness)
        best = bird;
    }
    avgScore = totalScore/birds.size();
    this.best = new Bird(best.brain);
    this.best.best = true;
    
    for (Bird bird : birds) {
      bird.fitness /= total;
    }
  }

  void naturalSelection() {
    ArrayList<Bird> newBirds = new ArrayList();
    for (int i = 1; i < birds.size(); i ++) {
      Bird parent = chooseParent();
      Bird child = new Bird(parent.brain.clone());
      newBirds.add(child);
    }
    newBirds.add(best);
    birds = (ArrayList<Bird>) newBirds.clone();
    gen ++;
  }

  Bird chooseParent() {
    float rand = random(1);
    float temp = 0;
    for (Bird b : birds) {
      temp += b.fitness;
      if (temp > rand) {
        return b;
      }
    }
    return birds.get(birds.size()-1);
  }

  void mutate() {
    for (Bird b : birds)
      b.brain.mutate();
  }
}
class Matrix {

  float[][] table;
  int rows;
  int cols;

  Matrix(int rows, int cols) {
    table = new float[rows][cols];
    this.rows = rows;
    this.cols = cols;
    for (int i = 0; i < rows; i ++) {
      for (int j = 0; j < cols; j ++) {
        table[i][j] = 0;
      }
    }
  }

  void printMatrix() {
    print("[");
    for (int i = 0; i < rows-1; i ++) {
      for (int j = 0; j < cols-1; j++) {
        print(table[i][j] + ", ");
      }
      println(table[i][cols-1]);
    }
    for (int j = 0; j < cols-1; j++) {
      print(table[rows-1][j] + ", ");
    }
    print(table[rows-1][cols-1]);
    println("]");
  }

  Matrix add(Matrix other) {
    Matrix result = null;
    if (this.rows == other.rows && this.cols == other.cols) {
      result = new Matrix(rows, cols);
      for (int i = 0; i < rows; i ++) {
        for (int j = 0; j < cols; j ++) {
          result.table[i][j] = this.table[i][j] + other.table[i][j];
        }
      }
    }
    return result;
  }

  Matrix sub(Matrix other) {
    Matrix result = null;
    if (this.rows == other.rows && this.cols == other.cols) {
      result = new Matrix(rows, cols);
      for (int i = 0; i < rows; i ++) {
        for (int j = 0; j < cols; j ++) {
          result.table[i][j] = this.table[i][j] - other.table[i][j];
        }
      }
    }
    return result;
  }

  Matrix mult(Matrix other) {
    Matrix result = null;
    if (this.cols == other.rows) {
      result = new Matrix(this.rows, other.cols);
      for (int rx = 0; rx < result.rows; rx ++) {
        for (int ry = 0; ry < result.cols; ry ++) {
          float sum = 0;
          for (int i = 0; i < this.cols; i ++) {
            sum += this.table[rx][i] * other.table[i][ry];
          }
          result.table[rx][ry] = sum;
        }
      }
    }
    return result;
  }

  void randomize() {
    for (int i = 0; i < rows; i ++) {
      for (int j = 0; j < cols; j ++) {
        table[i][j] = random(-1, 1);
      }
    }
  }

  Matrix sclmult(float scl) {
    Matrix result = new Matrix(rows, cols);
    for (int i = 0; i < rows; i ++) {
      for (int j = 0; j < cols; j++) 
        result.table[i][j] = scl * this.table[i][j];
    }
    return result;
  }

  Matrix elemmult(Matrix other) {
    Matrix result = null;
    if (rows == other.rows && cols == other.cols) {
      result = new Matrix(rows, cols);
      for (int i = 0; i < rows; i ++) {
        for (int j = 0; j < cols; j++) 
          result.table[i][j] = this.table[i][j] * other.table[i][j];
      }
    }
    return result;
  }

  Matrix transpose() {
    Matrix t = new Matrix(cols, rows);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j ++)
        t.table[j][i] = table[i][j];
    }
    return t;
  }

  Matrix clone() {
    Matrix result = new Matrix(rows, cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j ++)
        result.table[i][j] = table[i][j];
    }
    return result;
  }

  void mutate(float mutRate) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j ++)
        if (random(1) < mutRate)
          table[i][j] = table[i][j] + randomGaussian()*.5;
    }
  }

  Matrix fromArray(float[][] array) {
    int rows = array.length;
    int cols = array[rows-1].length;
    Matrix result = new Matrix(rows, cols);
    result.table = copyArray(array);
    return result;
  }

  float[][] copyArray(float[][] array) {
    float[][] result = new float[array.length][array[0].length];
    for (int i = 0; i < result.length; i ++ ) {
      for (int j = 0; j < result[0].length; j++) {
        result[i][j] = array[i][j];
      }
    }
    return result;
  }
}
BirdPopulation b;
ArrayList<Pipe> pipes = new ArrayList();
int counter = 1;
int hiScore = 0;
float avgScore = 0;

void resetGame() {
  pipes = new ArrayList();
  pipes.add(new Pipe(random(100, 500)));
  counter = 1;
}
 //<>//
//------------------------------------------------------------------------------------------------------
class NeuralNet {

  Matrix input_to_hidden;
  Matrix hidden_to_output;
  Matrix bias_hidden;
  Matrix bias_output;
  float lr = .1;

  NeuralNet(int input, int hidden, int output) {
    input_to_hidden = new Matrix(hidden, input);
    hidden_to_output = new Matrix(output, hidden);
    input_to_hidden.randomize();
    hidden_to_output.randomize();
    bias_hidden = new Matrix(hidden, 1);
    bias_output = new Matrix(output, 1);
    bias_hidden.randomize();
    bias_output.randomize();
  }

  Matrix feedforward(Matrix input) {
    Matrix h = input_to_hidden.mult(input).add(bias_hidden);
    activate(h);

    Matrix out = hidden_to_output.mult(h).add(bias_output);
    activate(out);
    return out;
  }

  void train(Matrix inputs, Matrix answers) {   //反馈
    Matrix h = input_to_hidden.mult(inputs).add(bias_hidden);
    activate(h);

    Matrix output = hidden_to_output.mult(h).add(bias_output);
    activate(output);

    Matrix err_o = answers.sub(output);

    Matrix grad_ob = output.sub(output.elemmult(output)).elemmult(err_o).sclmult(lr);
    Matrix gradient_ho = grad_ob.mult(h.transpose());
    bias_output = bias_output.add(grad_ob);
    hidden_to_output = hidden_to_output.add(gradient_ho);

    Matrix err_h = hidden_to_output.transpose().mult(err_o);

    Matrix grad_hb = h.sub(h.elemmult(h)).elemmult(err_h).sclmult(lr);
    Matrix gradient_ih = grad_hb.mult(inputs.transpose());
    bias_hidden = bias_hidden.add(grad_hb);
    input_to_hidden = input_to_hidden.add(gradient_ih);
  }

  void activate(Matrix input) {
    for (int i = 0; i < input.rows; i ++) {
      for (int j = 0; j < input.cols; j++) {
        input.table[i][j] = 1/(1+exp(-input.table[i][j]));
      }
    }
  }
  
  NeuralNet clone() {
    NeuralNet out = new NeuralNet(input_to_hidden.cols, input_to_hidden.rows, hidden_to_output.rows);
    out.input_to_hidden = input_to_hidden.clone();
    out.hidden_to_output = hidden_to_output.clone();
    out.bias_hidden = bias_hidden.clone();
    out.bias_output = bias_output.clone();
    out.lr = lr;
    return out;
  }
  
  void mutate() {
    float mutRate = .1;
    input_to_hidden.mutate(mutRate);
    hidden_to_output.mutate(mutRate);
    bias_hidden.mutate(mutRate);
    bias_output.mutate(mutRate);
    if (random(mutRate) < mutRate)
      lr = lr + randomGaussian() * .05;
  }
}
//------------------------------------------------------------------------------------------------------
class Pipe {  
  float spacing = 150;
  float top;
  float x;
  boolean onScreen = true;
  Pipe(float topLip) {
    top = topLip;
    x = width;
  }
  
  void show() {
    fill(0, 255, 0);
    rect(x, 0, 50, top);
    rect(x, top + spacing, 50, height - (top-spacing));
  }
  
  void update() {
    x -= 5;
    onScreen = x > -50;
    show();
  }
}
