float i,r,a,t=0;
void setup(){size(800,800);colorMode(HSB,1);noStroke();}
void draw(){scale(100);for(i=0;++i<4;){fill(1,.1);square(0,0,8);for(r=0;r<1;a=r*2*PI+t,fill(r+=.01,1,1,.8),circle(4+3*cos((4-3*cos(t))*a),4+3*sin((4-3*cos(t/2))*a),.1));t+=.002;}}
