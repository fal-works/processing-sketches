void setup(){
size(800,800);noStroke();
rectMode(CENTER);colorMode(HSB);
}
void draw(){
background(252);scale(10);
int i,f=frameCount;float x,r;
for(x=5;x<78;x+=5) for(i=1;i<16;r=pow(1-(f-i)%60/60.,3),fill(f%255,255,r*255),square(x,5*i++,1+2.5*r));
}
