int i,t=0;float[]x=new float[800];
void setup(){size(800,800);background(248);stroke(0,32);for(i=0;i<800;x[i++]=i);}
void draw(){for(i=0;i<800;point(x[i]+=noise(i++*.05,t*.01)-0.48,t));t++;}
