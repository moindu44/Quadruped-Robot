//PFrame f;
//secondApplet s;
//import processing.serial.*;

//Serial myPort; 
int val;  
float x,y,z,p,cx,cy,cz;
float a1,a2,a3,d1,d,t1,t2,t3;
float tx1,tx2,ty1,ty2,tz1,tz2;  // velocity controller
float tm1,tm2,vc=0;      // velocity and time controller
float i,j,k,l,m,n;
PFont fontA;
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float rotx = PI/4;
float roty = PI/4;
int rot=0;
int ck=0;             // keyboard controll of angle(1) or Position(1)
int cr=0;             // position arrry counter
float[] pointx = new float[3000000];
float[] pointy = new float[3000000];
float[] pointz = new float[3000000];

void setup() {
  size(700,500, P3D);
 // PFrame f = new PFrame();
  fill(204);
  a1=10*10;d1=1.3*10;                           // change according to actual
  a2=15*10;a3=11.5*10;
  t1=45*PI/180;t2=45*PI/180;t3=45*PI/180;
  x=60;
  y=60;
  z=-60;
  tx1=60;ty1=60;tz1=60;tx2=90;ty2=60;tz2=60;
  cx=sqrt(a1*a1-d1*d1)*cos(t1);cy=sqrt(a1*a1-d1*d1)*sin(t1);cz=0;
   fontA = loadFont("CourierNew36.vlw");                              // control frame
  textFont(fontA, 32);
  
  //String portName = Serial.list()[0];
  //myPort = new Serial(this, "COM3", 9600);
}

void draw() {
  lights();
  background(255);
  camera(0, height/2, (height/30) / tan(PI/6),
         width, height/2, 0,   // eye xyz
         0, 1, 0);
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);                             // rotation
  rotateY(roty);

  
  strokeWeight(1);                      // coordinates
  fill(0,255,0);
    line(0,0,0,200,0,0);
    text("X",200,0,0);
    strokeWeight(1);
    line(0,0,0,0,200,0);
    text("Y",-30,200,0);
    strokeWeight(1);
    line(0,0,0,0,0,200);
    text("Z",0,0,200);
  strokeWeight(5);
  robot();
  cal();
  
line(0,0,0,cx,cy,cz);             // Leges
line(cx,cy,cz,i,j,-k);
strokeCap(SQUARE);

translate(0,0, 0);                // circles
sphere(5);
translate(cx,cy,cz);
sphere(5);
translate(i-cx,j-cy,k-cz);
//sphere(5);
//translate(-i,-j,-k);
//velocity();
//locate();
if(vc==2)
{
  tx1=60;ty1=60;tz1=60;tx2=60;ty2=90;tz2=60;
  vc=0;
}

}
void locate()
{
  if(pointx[cr]!=x||pointy[cr]!=y||pointz[cr]!=z)
  {
    cr++;
    pointx[cr]=i;
    pointy[cr]=j;
    pointz[cr]=k;
  }
}

void velocity()
{
  if(vc==0)
  {
    tm1=millis();
    x=tx1;y=ty1;z=tz1;
    vc=1;
  }
  if(x!=tx2||y!=ty2||z!=tz2)
  {
    tm2=millis();
    if(tm2-tm1>=100||tm2-tm1<-500)
    {
    if(x<tx2)
    {
      x++;
    }
    else if(x>tx2)
    {
      x--;
    }
    
    if(y<ty2)
    {
      y++;
    }
    else if(y>ty2)
    {
      y--;
    }
    
    if(z<tz2)
    {
      z++;
    }
    else if(z>tz2)
    {
      z--;
    }
  }
  else if(x==tx2&&y==ty2&&z==tz2)
  {
  vc=2;
}
  }
//  stroke(0,0,255);
//   line(tx1,ty1,tz1,x,y,z);
 //  stroke(0);
}

void cal()
{
  cx=a1*cos(t1);cy=a1*sin(t1);cz=0;
  i=cx+a2*cos(t2)*cos(t1);
  j=cy+a2*cos(t2)*sin(t1);
  k=cz+a2*(sin(t2));
  l=i+a3*cos(t2+t3)*cos(t1);
  m=j+a3*cos(t2+t3)*sin(t1);
  n=k+a3*(sin(t2+t3));
  show();
}
void show()                 // sowing the value of angle and axis
{
  
strokeWeight(5);
stroke(255,0,0);
for(int bm=0;bm<=cr;bm++)
{
point(pointx[bm],pointy[bm],pointz[bm]);
}
stroke(0);
  fill(0,0,255);
  //rotateX(-PI/2);
  text("X_pos=", 5,160);                    
  text(x, 120,160);
  //rotateX(PI/2);
  text("Y_pos=", 5,190);
  text(y, 120,190);
  text("Z_pos=", 5,220);
  text(z, 120,220);
  text("t1=", 5,250);
  text(t1*180/PI, 80,250);
  text("t2=", 5,280);
  text(t2*180/PI, 80,280);
  //text("t3=", 5,280);
//  text(t3*180/PI, 80,280);
}
  
void robot()
{                          
  
   d=((x-cx)*(x-cx)+(y-cy)*(y-cy)+(z-d1)*(z-d1)-a2*a2-a3*a3)/(2*a2*a3);
   t1=atan2(y,x);
   t3= atan2(-sqrt(1-d*d),d);
   t2= atan2((z-d1),sqrt((x-cx)*(x-cx)+(y-cy)*(y-cy)))-atan2(a3*sin(t3),(a2+a3*cos(t3)));
}
void keyPressed()                             // keyboard function 
{
  if(ck==1)
  {
    if (key =='+')
    {
       t1=t1+5*PI/180;
      if(t1*PI/180>180)
      t1=180*PI/180;
    }
    else if(key=='-')
    t1=t1-5*PI/180;
      if(t1*PI/180<0)
      t1=0;
  
  if (key == CODED) 
  {
    if (keyCode == RIGHT) 
    {
      t2=t2+5*PI/180;
      if(t2*PI/180>180)
      t2=180*PI/180;
    }
    if(keyCode== LEFT)
    {
      t2=t2-5*PI/180;
      if(t2*PI/180<0)
      t2=0;
    }
    if(keyCode== UP)
    {
      t3=t3+5*PI/180;
      if(t3*PI/180>180)
      t3=180*PI/180;
    }
    if(keyCode== DOWN)
    {
      t3=t3-5*PI/180;
      if(t3*PI/180<0)
      t3=0;
    }
  }
  }
  else
  {
    
    if (key =='+')
    {
      z++;
    }
    else if(key=='-')
    {
      z--;
    }
  
  if (key == CODED) 
  {
    if (keyCode == RIGHT) 
    {
      x++;
    }
    if(keyCode== LEFT)
    {
      x--;
    }
    if(keyCode== UP)
    {
      y--;
    }
    if(keyCode== DOWN)
    {
      y++;
    }
  }
  }
}

void mouseDragged() {                                 // mouse draging
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
  
//myPort.write(str(int(t1*180/PI))+"a"); 
//myPort.write(str(int(t2*180/PI))+"b"); 
//myPort.write(str(int(t3*180/PI))+"c"); 

println(t1*180/PI);

}
/*                                                    // Controll frame start
public class PFrame extends Frame {
     public PFrame() {
         setBounds(100,100,400,300);
         s = new secondApplet();
         add(s);
         s.init();
         show();
     }
 }

public class secondApplet extends PApplet {  
  public void setup() {
         size(400, 300);
     }

     public void draw() {
       
        fill(200,0,0);
        textSize(32);
        text("controll panel",10,100);
        text("is in construction",10,130);
        text("please use keyboards",10,160);
        text("LEFT,RIGHT,UP,DOWN,",0,200);
        text(",'+','-' button",0,240);
     }
void keyPressed() 
{
 
    if (key =='+')
    {
    }
    else if(key=='-')
    {
    }
  
  if (key == CODED) 
  {
    if (keyCode == RIGHT) 
    {
    }
    if(keyCode== LEFT)
    {
    }
    if(keyCode== UP)
    {
    }
    if(keyCode== DOWN)
    {
    }
 }
}}*/
