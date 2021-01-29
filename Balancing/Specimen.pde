import java.util.Collections;
class Specimen implements Comparable<Specimen> {
  
  PendulumCart cart;
  Cubic driver;
  
  float deviation;
  
  Specimen(){
    deviation = 0;
    cart = new PendulumCart();
    driver = new Cubic();
  
    driver.subject = cart;
    driver.initialize();
  
    cart.constrainTo(rail);
    cart.theta(0.0);
    cart.omega(0.0);
    cart.velocity(0);
  }
  
  void carbon(Specimen s){
    
    cart = new PendulumCart();
    cart.constrainTo(rail);
    cart.theta(-0.0);
    cart.omega(0.0);
    cart.velocity(0);
    
    driver = new Cubic();
    driver.carbon(s.driver);
    driver.subject = cart;
  }
  void mutate(float scale){
    driver.mutate(scale);
  }
  void update(float dt){
    cart.update(dt);
    driver.update(dt);
    driver.exert();
    
    integrateFit(dt);
  }
  
  void integrateFit(float dt){
    deviation += 10000*(pow(cart.theta(),2)*dt + pow(cart.position(),2)*dt/64);
    if(!driver.alive){
      deviation = 1000000;
    }
  }
  
  void render(){
    driver.render();
    cart.render();
    //ptr.render();
  }
  
  @Override
  int compareTo(Specimen other) {
      return int(this.deviation - other.deviation);
   }
}
