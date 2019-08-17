float[][][]d=new float[32][2][2];
float f(float[]x){return x[0]+=((frameCount%30==0?x[1]=random(100):x[1])-x[0])/4;}
void setup(){size(800,800);fill(252,32);}
void draw(){square(0,0,800);scale(8);for(float[][]e:d)line(e[0][0],e[1][0],f(e[0]),f(e[1]));}
