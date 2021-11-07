int lifetime;  
Population population;  
int lifeCounter;   // 计数
int simSpeed = 2;   //速度
float maxFitnessGlobal =0;
PVector target;   

/*
import gifAnimation.*;
GifMaker gifExport;
*/

//----------------------------------------------------------------------------------
void setup() {
  size(1000, 1200);
  lifetime = height/simSpeed;  //允许一代生存的周期
  lifeCounter = 0;   //初始化
  target = new PVector(width/2, 100);   //目标靶子

  float mutationRate = 0.001;    //突变率
  population = new Population(mutationRate, 500);   //种群数
  
  /*
  gifExport = new GifMaker(this,"export.gif");
  gifExport.setRepeat(0); // = 永远循环
  */
  
}
//-----------------------------------------------------------------------------------
void draw() {
  background(255);
  fill(0);
  ellipse(target.x, target.y, 24, 24);
  
  if (lifeCounter < lifetime) {    //判断一代是否结束
    population.live();
    lifeCounter++;
  } else {
    lifeCounter = 0;
    
    population.fitness();
    population.selection();
    population.reproduction();
  }
//-------------------------------------------------显示文字--------------------------
  fill(0);
  text("Generation       : " + population.getGenerations(), 10, 18);
  text("Cycles left      : " + (lifetime-lifeCounter), 10, 36);
  text("Maximum Fitness  : " + maxFitnessGlobal, 10, 54);
  text("Simulation speed : " + (simSpeed), 10, 72);
  
  /*
  if (frameCount%2==0 &&  frameCount<1000) {
  gifExport.setDelay(10);  //动画 GIF 的速度
  gifExport.addFrame();
  }
  if (frameCount>1000) gifExport.finish();
  */
}
//-----------------------------------------------------------------------------------

void mousePressed() {    //点击鼠标，移动目标，系统也将适应新目标
  target.x = mouseX;
  target.y = mouseY;
}

class DNA {    //基因序列
  PVector[] genes;
  float maxforce = 0.5*simSpeed;    //最大强度

  DNA() {                                //构造
    genes = new PVector[lifetime];
    for (int i = 0; i < genes.length; i++) {
      float angle = random(TWO_PI);
      genes[i] = new PVector(cos(angle), sin(angle));
      genes[i].mult(random(0, maxforce));
    }
  }

  DNA(PVector[] newgenes) {   //创建    有必要再复制一份
    genes = newgenes;
  }

  DNA crossover(DNA partner) {    //创建新的序列
    PVector[] child = new PVector[genes.length];
    int crossover = int(random(genes.length));

    for (int i = 0; i < genes.length; i++) {   //一个取一半
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }    
    DNA newgenes = new DNA(child);
    return newgenes;
  }

  void mutate(float m) {    //基于变异概率，选择一个新的随机向量
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < m) {
        float angle = random(TWO_PI);
        genes[i] = new PVector(cos(angle), sin(angle));
        genes[i].mult(random(0, maxforce));
      }
    }
  }
}

//-----------------------------------------------------------------------------------

class Population {
  float mutationRate;    // 变异速率
  Rocket[] population;         // 保存进数组
  ArrayList<Rocket> matingPool;    //交配池
  int generations;             // 代数

   Population(float m, int num) {
    mutationRate = m;
    population = new Rocket[num];
    matingPool = new ArrayList<Rocket>();
    generations = 0;

    for (int i = 0; i < population.length; i++) {    //一组新的
      PVector position = new PVector(width/2,height+20);
      population[i] = new Rocket(position, new DNA());
    }
  }
//---------------------------------------飞起来--------------------------------------------
  void live () {     
    for (int i = 0; i < population.length; i++) {
      population[i].run();
    }
  }
//----------------------------------------适应度-------------------------------------------
  void fitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
  }
//-----------------------------------------------------------------------------------------
  void selection() {
    matingPool.clear();
    float maxFitness = getMaxFitness();
    maxFitnessGlobal = getMaxFitness();
    
    for (int i = 0; i < population.length; i++) {
      float fitnessNormal = map(population[i].getFitness(),0,maxFitness,0,1);   //计算每个个体的适应度   0，1之间的值
      int n = (int) (fitnessNormal * 100);                               //根据适应度大小，每个个体被加入交配池次数相应多少
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
//----------------------------------------下一代-------------------------------------------
  void reproduction() {     //重新填充
    for (int i = 0; i < population.length; i++) {
      int m = int(random(matingPool.size()));          //随机       选择父代、母代
      int d = int(random(matingPool.size()));

      Rocket mom = matingPool.get(m);
      Rocket dad = matingPool.get(d);

      DNA momgenes = mom.getDNA();      //获取基因
      DNA dadgenes = dad.getDNA();

      DNA child = momgenes.crossover(dadgenes);      //交配

      child.mutate(mutationRate);           //突变

      PVector position = new PVector(width/2,height+20);
      population[i] = new Rocket(position, child);
    }
    generations++;
  }
  
//------------------------------------------------------------------------------------------
  int getGenerations() {
    return generations;
  }

  float getMaxFitness() {                     //最高适应度
    float record = 0;
    for (int i = 0; i < population.length; i++) {
       if(population[i].getFitness() > record) {
         record = population[i].getFitness();
       }
    }
    return record;
  }

//------------------------------------------------------------------------------------------ 
  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }

}
//---------------------------------------------------结束class Population ---------------------------------------

class Rocket {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float fitness;
  DNA dna;

  int geneCounter = 0;
  boolean hitTarget = false;    //未击中
  
  Rocket(PVector l, DNA dna_) {
    acceleration = new PVector();
    velocity = new PVector();
    position = l;
    r = 4;
    dna = dna_;
  }

  void fitness() {             //适应度
    float d = dist(position.x, position.y, target.x, target.y);
    fitness = pow(1/d, 3);
  }

  void run() {
    checkTarget(); // 是否击中
    if (!hitTarget) {
      applyForce(dna.genes[geneCounter]);
      geneCounter = (geneCounter + 1) % dna.genes.length;
      update();
    }
    display();
  }

  void checkTarget() {
    float d = dist(position.x, position.y, target.x, target.y);
    if (d < 18) {
      hitTarget = true;
    } 
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    fill(175);                       //火箭显示表达
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  float getFitness() {
    return fitness;
  }

  DNA getDNA() {
    return dna;
  }
}
