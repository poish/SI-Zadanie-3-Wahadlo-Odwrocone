

Rail rail;
PendulumCart p;
Cubic c;
Controller ptr;

Specimen s;
Specimen s2;

Population pop;

float GenerationTime;
int GenerationCount;
float dt = 1.0/120.0;
void setup(){
  
  size(900, 600);
  initializeGUI();
  
  GenerationTime = 0;
  GenerationCount = 0;
  
  rail = new Rail(6, 1);
  s = new Specimen();

  pop = new Population(64);
  pop.initialize(0,0.1,0.15);
  frameRate(120);
}
void draw(){
  background(20);
  
  rail.render();
  
  pop.update(dt);
  pop.render();
  
  GenerationTime += dt;
  if(GenerationTime > 8){
    pop.assess();
    pop.cull();
    pop.repopulate();
    pop.initialize(0,0.2,0.2);
    GenerationTime = 0;
    GenerationCount++;
  }
  
  updateGUI();
}
