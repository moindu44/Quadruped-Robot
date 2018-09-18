float x,y,p,q,c,d,cx,cy;
float a,b,t1,t2;
PFont fontA;
void setup() {
  size(600,600);
  a=100;b=150;
  t1=90;t2=90;
  c=100;d=150;
  cx=100;cy=300;
  
   fontA = loadFont("CourierNew36.vlw");
  textFont(fontA, 32);
}


void draw() {
  background(255);
  
  for(int i=10;i<600;i=i+10)
  {
    strokeWeight(1);
    line(i,0,i,600);
  }
  for(int j=10;j<600;j=j+10)
  {
    strokeWeight(1);
    line(0,j,600,j);
  }
  strokeWeight(10);
  strokeCap(ROUND);
  
  robot();
   cal();
line(cx,cy,x,y);
strokeCap(ROUND);
line(x,y,p,q);
strokeCap(SQUARE);
  
}

void cal()
{
  x=cx+a*cos((t1));
  y=cy+a*sin((t1));
  p=x+b*cos((t1+t2));
  q=y+b*sin((t1+t2));
    fill(0,0,255);
    text("(0,0)",50,280);
    text("Use LEFT, RIGHT, UP, DOWN", 5,30);
    text(" arrow key to controll", 5,60);
    text("X_pos=", 5,100);
  text(p-100, 120,100);
  text("Y_pos=", 5,130);
  text((q-300), 120,130);
}
  
void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == RIGHT) 
    {
      c++;
      /*t1=t1+5;
      if(t1>180)
      t1=180;*/
    }
    if(keyCode== LEFT)
    {
      c--;
      /*t1=t1-5;
      if(t1<0)
      t1=0;*/
    }
    if(keyCode== UP)
    {
      d--;
     /* t2=t2+5;
      if(t2>180)
      t2=180;*/
    }
    if(keyCode== DOWN)
    {
      d++;
      /*t2=t2-5;
      if(t2<0)
      t2=0;*/
    }
  }
}
void robot()
{                                                        //thik nai
  
  float m=(c*c+d*d-a*a-b*b)/(2*a*b);
  //t2=acos(m)*180/3.1416;
   t2= atan2(sqrt(1-m*m),m);
/*   if(t2<0){
    t2=t2+PI;
    }*/
   t1= atan2(d,c)-atan2(b*sin(t2),(a+b*cos(t2)));
   
  /*t1= (atan(d/c)*180/PI-atan(b*sin(t2)*180/PI/(a+b*cos(t2)*180/PI)));
  if(t1<-PI/2)
  {
    t1=t1+PI;
  }
  if(t1>PI/2)
  {
    t1=PI-t1;
  }
  t1= t1*180/PI;
  t2= t2*180/PI;
  if(t1<0)
  {
    t1=t1+180;
  }
  if(t2<0){
    t2=t2+180;
  }*/
print(c+"    ");
print(d+"    ");
print(t1+"    ");
println(t2);
}
