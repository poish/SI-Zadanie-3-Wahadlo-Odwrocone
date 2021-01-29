class Rail {

  float halfLength;
  float drag;
  float restitution;
  
  Rail(float len, float dragCoeff){
    halfLength = len/2;
    drag = dragCoeff;
    restitution = 0.9;
  }
  float drag(float x, float v){
    return drag;
  }
  void render(){
  
    PhysCoord left = new PhysCoord(-halfLength,0);
    PhysCoord right = new PhysCoord(halfLength,0);
    
    ScreenCoord lc = left.toScreen();
    ScreenCoord rc = right.toScreen();
    
    stroke(235);
    strokeWeight(2);
    fill(20);
    ellipseMode(CENTER);
    line(lc.x, lc.y, rc.x, rc.y);
    ellipse(lc.x, lc.y, 10,10);
    ellipse(rc.x, rc.y, 10,10);
  }
}
