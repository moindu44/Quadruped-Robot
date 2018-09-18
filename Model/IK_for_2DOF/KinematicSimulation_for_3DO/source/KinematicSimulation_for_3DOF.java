import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class KinematicSimulation_for_3DOF extends PApplet {

PFrame f;
secondApplet s;

float x,y,z,p,cx,cy,cz;
float a1,a2,a3,d1,d,t1,t2,t3;
float i,j,k,l,m,n;
PFont fontA;
float xmag, ymag = 0;
float newXmag, newYmag = 0; 
float rotx = PI/4;
float roty = PI/4;
int rot=0;
int ck=0;

public void setup() {
  size(1000,700, P3D);
  PFrame f = new PFrame();
  fill(204);
  a1=2.7f*10;d1=1.3f*10;                           // change according to actual
  a2=4.6f*10;a3=11.5f*10;
  t1=45*PI/180;t2=45*PI/180;t3=45*PI/180;
  x=60;
  y=60;
  z=-60;
  
  cx=sqrt(a1*a1-d1*d1)*cos(t1);cy=sqrt(a1*a1-d1*d1)*sin(t1);cz=d1;
   fontA = loadFont("CourierNew36.vlw");                              // control frame
  textFont(fontA, 32);
}

public void draw() {
  lights();
  background(255);
  camera(0, height/2, (height/30) / tan(PI/6),
         width, height/2, 0,   // eye xyz
         0, 1, 0);
  translate(width/2.0f, height/2.0f, -100);
  rotateX(rotx);                             // rotation
  rotateY(roty);

  
  strokeWeight(1);                      // coordinates
    line(0,0,0,300,0,0);
    text("X",300,0,0);
    strokeWeight(1);
    line(0,0,0,0,300,0);
    text("Y",0,300,0);
    strokeWeight(1);
    line(0,0,0,0,0,300);
    text("Z",0,0,300);
  strokeWeight(5);
  robot();
  cal();
  
line(0,0,0,cx,cy,cz);             // Leges
line(cx,cy,cz,i,j,k);
line(i,j,k,l,m,n);
strokeCap(SQUARE);

translate(0,0, 0);                // circles
sphere(5);
translate(cx,cy,cz);
sphere(5);
translate(i-cx,j-cy,k-cz);
sphere(5);
}

public void cal()
{
  cx=sqrt(a1*a1-d1*d1)*cos(t1);cy=sqrt(a1*a1-d1*d1)*sin(t1);cz=d1;
  i=cx+a2*cos(t2)*cos(t1);
  j=cy+a2*cos(t2)*sin(t1);
  k=cz+a2*(sin(t2));
  l=i+a3*cos(t2+t3)*cos(t1);
  m=j+a3*cos(t2+t3)*sin(t1);
  n=k+a3*(sin(t2+t3));
  show();
}
public void show()                 // sowing the value of angle and axis
{
  fill(0,0,255);
  text("X_pos=", 5,100);                    
  text(x, 120,100);
  text("Y_pos=", 5,130);
  text(y, 120,130);
  text("Z_pos=", 5,160);
  text(z, 120,160);
  text("Theta1=", 5,200);
  text(t1*180/PI, 120,200);
  text("Theta2=", 5,230);
  text(t2*180/PI, 120,230);
  text("Theta3=", 5,260);
  text(t3*180/PI, 120,260);
}
  
public void robot()
{                          
  
   d=((x-cx)*(x-cx)+(y-cy)*(y-cy)+(z-d1)*(z-d1)-a2*a2-a3*a3)/(2*a2*a3);
   t1=atan2(y,x);
   t3= atan2(-sqrt(1-d*d),d);
   t2= atan2((z-d1),sqrt((x-cx)*(x-cx)+(y-cy)*(y-cy)))-atan2(a3*sin(t3),(a2+a3*cos(t3)));
}
public void keyPressed()                             // keyboard function 
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

public void mouseDragged() {                                 // mouse draging
  float rate = 0.01f;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}

public void velocity()
{
  
}
                                                    // Controll frame start
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
public void keyPressed() 
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
}}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "KinematicSimulation_for_3DOF" });
  }
}
