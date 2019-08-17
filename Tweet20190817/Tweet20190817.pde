float r,a,t=0;
void setup(){size(800,800);noStroke();colorMode(HSB,1);}
void draw(){
scale(200);blendMode(NORMAL);fill(0,0,1,.1);square(0,0,4);blendMode(DIFFERENCE);
for(r=0;r<1;a=r*2*PI+t,fill(r+=.05,1,1,.5),circle(2+cos(3*a),2+sin(4*a),.3));t+=.007;
}
