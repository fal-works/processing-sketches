size(800,800);
background(252);
noFill();
rectMode(CENTER);
colorMode(HSB);
float x=300, y=300, a=0;
for(int i=0; i<64; i++){
 push();
 translate(x,y); rotate(a);
 stroke(4*i,255,128); strokeWeight(i/32.0);
 rect(0,0,450,450,10);
 pop();
 x+=3; y+=3; a+=0.1;
}
