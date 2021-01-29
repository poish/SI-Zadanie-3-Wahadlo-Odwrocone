class Population {
  ArrayList<Specimen> specimens;
  Specimen best;
  float averageDev;
  
  Population(int count){
    averageDev = 0;
    specimens = new ArrayList<Specimen>();
    
    for(int i = 0; i < count; i++){
      Specimen spec = new Specimen();    
      specimens.add(spec);
    }
  }
  void initialize(float posVar, float thetaVar, float omegaVar){
    for(Specimen spec: specimens){
      spec.deviation = random(0.1);
      spec.cart.position(posVar*(2*random(1)-1));
      spec.cart.theta(thetaVar*(2*random(1)-1));
      spec.cart.omega(omegaVar*(2*random(1)-1));
    }
  }
  void assess(){
    Collections.sort(specimens);
    
    float totalDev = 0;
    for(Specimen spec: specimens){
      if(spec.driver.alive){
        totalDev += spec.deviation;
      }
    }
    averageDev = totalDev / float(specimens.size());
  }
  void cull(){
    int elitism = 16;
    ArrayList<Specimen> culled = new ArrayList<Specimen>();
    for(int i = 0; i < elitism; i++){
      culled.add(specimens.get(i));
    }
    specimens = culled;
  }
  void repopulate(){
    
    ArrayList<Specimen> children = new ArrayList<Specimen>();
    for(Specimen spec: specimens){  
      for(int i = 0; i < 3; i++){  // Each survivor gets three children to bring the total back to 48
        Specimen offspring = new Specimen();
        offspring.carbon(spec);
        offspring.mutate(0.00001);
        children.add(offspring);
      }  
    }
    
    for(Specimen ch: children){
      specimens.add(ch);
    }
  }
  void update(float dt){
    for(Specimen spec: specimens){
      spec.update(dt);
    }
  }
  void render(){
    for(Specimen spec: specimens){
      spec.render();
    }
  }
}
