float s,x,n,t=0,l=800;
void setup(){size(800,800);colorMode(3,10);blendMode(32);}
void f(){for(x=s=0;x<l;x++){n=noise(x*.01,t);if(s>0&n<.6)rect(s,0,x-s,l+(s=0));if(s<1&n>.6)s=x;}}
void draw(){background(0,0,10);t++;fill(1,9,3,5);f();t-=.99;fill(8,9,3,5);f();}
