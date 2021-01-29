static class Env{
  static float ScreenWidth = 900;
  static float ScreenHeight = 600;
  
  static float RegionWidth = 9;
  static float RegionHeight = 6;
}
class ScreenCoord {
  int x, y;
  ScreenCoord(int ix, int iy){
    x = ix;
    y = iy;
  }
  
  PhysCoord toPhys(){
    float a = Env.RegionWidth/Env.ScreenWidth;
    float b = -Env.RegionWidth/2;
    
    float p = -Env.RegionHeight/Env.ScreenHeight;
    float q = Env.RegionHeight/2;
    
    return new PhysCoord(a*float(x) + b, p*float(y) * q);
  }
}
class PhysCoord{
  float x, y;
  PhysCoord(float ix, float iy){
    x = ix;
    y = iy;
  }
  ScreenCoord toScreen(){
    float a = Env.ScreenWidth/Env.RegionWidth;
    float b = Env.ScreenWidth/2;
    
    float p = -Env.ScreenHeight/Env.RegionHeight;
    float q = Env.ScreenHeight/2;
    
    return new ScreenCoord(int(a*x+b), int(p*y+q));
  }
}
