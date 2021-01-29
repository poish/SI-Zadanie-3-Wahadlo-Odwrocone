class Controller {
  
  PendulumCart subject;
  float time;
  
  boolean active;
  boolean visible;
  boolean alive;
  color col;
  
  float indicatorScale;
  float indicatorOffset;
  
  Controller(){
    time = 0;
    indicatorScale = 10;
    indicatorOffset = 0.5;
    
    active = true;
    visible = true;
    alive = true;
    col = color(random(255), random(255), random(255));
    
  }
  void update(float dt){
    time += dt;
  }
  float out(){
    return 0;
  }
  void exert(){
    if(alive){
      subject.addForce(out());
    }
    if(out() > 50){
      alive = false;
    }
  }
  void initialize(){}
  void mutate(){}
  void render(){
    if(visible && active && alive){
      float x = subject.position();
      float y = 1 + indicatorOffset;
      
      ScreenCoord start = new PhysCoord(x,y).toScreen();
      
      noStroke();
      fill(col);
      rectMode(CENTER);
      rect(start.x + int(indicatorScale*out()/2), start.y + indicatorOffset, int(indicatorScale*out()), 5);
    }
  }
}

class Basic extends Controller {
  Basic(){
  }
  float out(){
    float p = subject.position();
    float v = subject.velocity();
    float th = (subject.theta() % PI);
    float om = subject.omega();
    
    // Good basic return 1*v  + -50*th + -5*pow(th,3);
    
    // This one even centers
    
    //return 1*v*(1-0.5*p) + 0.2*p  + -50*th + -8.5*pow(th,3) + 1.5*v*om*pow(p,3);
    return 1*v*(1-0.5*p) + 0.2*p  -40*th + -8.5*pow(th,3) + 1.0*v*om*p; 
  }
  
}
class Pointer extends Controller {
  
  float out(){
    if(mousePressed){
      PhysCoord mouse = new ScreenCoord(mouseX, mouseY).toPhys(); 
      return mouse.x - subject.position();
    }
    else{
      return 0;
    }
  }
}
class Cubic extends Controller {
  
  float[] l;  // linear coefficients
  float[] q;  // quadratic coefficients
  float[] c;  // cubic coefficients
  Cubic(){
    l = new float[4];
    q = new float[10];
    c = new float[20];
    for(int i = 0; i < 4; i++){
      l[i] = 0.0;
    }
    for(int i = 0; i < 10; i++){
      q[i] = 0.0;
    }
    for(int i = 0; i < 20; i++){
      c[i] = 0.0;
    }
  }
  void initialize(){
    l[0] = 0.2;    // p
    l[1] = 1.0;    // v
    l[2] = -40.0;  // th
    
    q[4] = -0.5;    // pv
    
    c[2] = -8.5;   // th^3
    c[17] = 1.0;   // p*v*om
    
  }
  float out(){
    float p = subject.position();
    float v = subject.velocity();
    float th = (subject.theta() % PI);
    float om = subject.omega();
    
    float linSum = l[0]*p + l[1]*v + l[2]*th + l[3]*om;
    
    float qdrSum = q[0]*pow(p,2) + q[1]*pow(v,2) + q[2]*pow(th,2) + q[3]*pow(om,2)
                 + q[4]*p*v + q[5]*v*th + q[6]*th*om + q[7]*p*th
                 + q[8]*v*om + q[9]*p*om;
                 
    float cubSum = c[0]*pow(p,3) + c[1]*pow(v,3) + c[2]*pow(th,3) + c[3]*pow(om,3)
                 + c[4]*pow(p,2)*v + c[5]*pow(v,2)*p + c[6]*pow(v,2)*th + c[7]*pow(th,2)*v
                 + c[8]*pow(th,2)*om + c[9]*pow(om,2)*th + c[10]*pow(p,2)*th
                 + c[11]*pow(th,2)*p + c[12]*pow(v,2)*om + c[13]*pow(om,2)*v
                 + c[14]*pow(p,2)*om + c[15]*pow(om,2)*p
                 + c[16]*p*v*th + c[17]*p*v*om + c[18]*p*th*om + c[19]*v*th*om;
                 
    return linSum + qdrSum + cubSum;
  }
  void carbon(Cubic src){
    for(int i = 0; i < 4; i++){
      l[i] = src.l[i];
    }
    for(int i = 0; i < 10; i++){
      q[i] = src.q[i];
    }
    for(int i = 0; i < 20; i++){
      c[i] = src.c[i];
    }
  }
  
  void mutate(float scale){
    for(int i = 0; i < 4; i++){
      l[i] += scale*(2*random(1)+1);
    }
    for(int i = 0; i < 10; i++){
      q[i] += 0*scale*(2*random(1)+1);
    }
    for(int i = 0; i < 20; i++){
      c[i] += scale*(2*random(1)+1);
    }
    /*
    int choice = int(random(35));
    if(choice < 4){ l[choice] += scale*(2*random(1)+1);}
    if((4 <= choice) && (choice < 14)){ q[choice-4] += scale*(2*random(1)+1);}
    if((14 <= choice) && (choice < 34)){ c[choice-14] += scale*(2*random(1)+1);}
    */
  }
}
