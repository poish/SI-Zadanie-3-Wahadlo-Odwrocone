class PendulumCart {
  
  float pos, vel;
  float theta, omega, epsilon;
  float cartMass, rodLength, bobMass;
  float force;
  
  Rail rail;
  
  PendulumCart(){
    pos = 0;
    vel = 0;
    theta = 0;
    omega = 0;
    epsilon = 0;
    force = 0;
    cartMass = 1;
    rodLength = 1;
    bobMass = 0.2;
  }
  void position(float p){ pos = p; }
  void velocity(float v){ vel = v; }
  void theta(float th){ theta = th; }
  void omega(float om){ omega = om; }
  void epsilon(float ep){ epsilon = ep; }
  void force(float f){ force = f; }
  void addForce(float f){ force += f; }
  void cartMass(float m){ cartMass = m; }
  void rodLength(float l){ rodLength = l; }
  void bobMass(float m){ bobMass = 0.2; }
  void constrainTo(Rail cnstr){ rail = cnstr; }
  
  float position(){ return pos; }
  float velocity(){ return vel; }
  float theta(){ return theta; }
  float omega(){ return omega; }
  float cartMass(){ return cartMass; }
  float rodLength(){ return rodLength; }
  float bobMass(){ return bobMass; }
  
  void update(float dt){
    if(atBounds()){
      
      pos = biclamp(pos, rail.halfLength);
      float velocityChange = -2*vel; 
      float omegaChange = cos(theta)*velocityChange/rodLength;
      
      vel += velocityChange*rail.restitution;
      omega += omegaChange;
    }
    
    force += -vel * rail.drag(pos, vel);
    
    float A = bobMass + cartMass;
    float B = -bobMass*rodLength*cos(theta);
    float C = -cos(theta);
    float D = rodLength;
    
    float P = force - bobMass*rodLength*pow(omega,2)*sin(theta);
    float Q = 9.81 * sin(theta); // G = 9.81
    
    float invdet = 1/(A*D - B*C);
    
    float acc = invdet*(D*P - B*Q);
    float epsilon = invdet*(-C*P + A*Q);
    
    vel += acc*dt;
    pos += vel*dt + acc*pow(dt,2)/2;
    
    omega += epsilon*dt;
    theta += omega*dt + epsilon*pow(dt,2)/2;
    
    force = 0;
  }
  
  boolean atBounds(){
    return pow(pos, 2) > pow(rail.halfLength, 2);
  }
  
  float biclamp(float value, float limit){  // clamps value to [-limit; limit]
    if(value <= limit){
      if(value >= -limit){
        return value;
      }
      else{
        return -limit;
      }
    }
    else{
      return limit;
    }
  }
  
  void render(){
    
    PhysCoord box = new PhysCoord(pos, 0);
    ScreenCoord box_sc = box.toScreen();
    
    PhysCoord bob = new PhysCoord(pos - rodLength*sin(theta), rodLength*cos(theta));
    ScreenCoord bob_sc = bob.toScreen();
    
    fill(20);
    stroke(235);
    rectMode(CENTER);
    ellipseMode(CENTER);
    
    line(box_sc.x, box_sc.y, bob_sc.x, bob_sc.y);
    ellipse(bob_sc.x, bob_sc.y, 10,10);
    rect(box_sc.x, box_sc.y, 50,20);
    ellipse(box_sc.x, box_sc.y, 10,10);
  }
}
