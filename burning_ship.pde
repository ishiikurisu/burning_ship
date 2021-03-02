final color WHITE = #FFFFFF;
final color BLACK = #000000;
final int MAX_ITR = 1024;
float[] frameInit;  // [x, y]
float[] frameEnd;

void firstSetting() {
  frameInit = new float[2];
  frameEnd = new float[2];
  
  if (height > width) {
    frameInit[0] = -1.0;
    frameInit[1] = -((float)height/((float)width));
    frameEnd[0] = 1.0;
    frameEnd[1] = (float)height/((float)width);
  } else {
    frameInit[0] = -width / height;
    frameInit[1] = -1.0;
    frameEnd[0] = width / height;
    frameEnd[1] = 1.0;
  }
}

float pit(float a, float b) {
  return sqrt(a*a + b*b);
}

boolean escapes(float x, float y) {
   float zx = 0.0;
   float zy = 0.0;
   float temp;
   
   for (int i = 0; i < MAX_ITR && pit(zx, zy) <= 2.0; i++) {
     temp = zx*zx - zy*zy + x; 
     zy = abs(2 * zx * zy) + y;
     zx = temp;
   }
  
  return pit(zx, zy) > 2;
}

void setPixel(float x, float y, boolean v) {
  if (v) {
    float posX = ((x - frameInit[0]) * width) / (frameEnd[0] - frameInit[0]);
    float posY = ((frameEnd[1] - y) * height) / (frameEnd[1] - frameInit[1]);
    point(posX, posY);
  }
}

void burningShip() {
  background(WHITE);
  stroke(BLACK);
  fill(BLACK);
  
  float dy = (frameEnd[1] - frameInit[1]) / (float) height;
  float dx = (frameEnd[0] - frameInit[0]) / (float) width;
  
  for (float y = frameInit[1]; y < frameEnd[1]; y += dy) {
    for (float x = frameInit[0]; x < frameEnd[0]; x += dx) {
      setPixel(x, y, !escapes(x, y));
    }
  }
}

void setup() {
  size(800, 600, P2D);
  firstSetting();
  burningShip();
}

void draw() {
}
