// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
char command;
String string;
 
//Servo myservo;  // create servo object to control a servo 
//     Servo myservo1;           // a maximum of eight servo objects can be created 
 Servo s[8];
int pos = 0;    // variable to store the servo position 
int a[8];
int e1=20,e2=25;
int dl=80;
int num=10;
int con=0;
void setup() 
{ 
 //myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
//myservo1.attach(10);

 Serial.begin(9600);
a[0]=90+30;
a[2]=90-30;
a[4]=90+30;
a[6]=90-45;
for(int i=0;i<8;i++)
{
  if(i%2==1)
  {
 a[i]=90;
  }
  if(i==3)
  {
    a[i]=100;
  }
  
  if(i==3)
  {
    s[i].attach(3);
  }
  else if(i==0)
  {
    s[i].attach(2);
  }
  else
  {
  s[i].attach(i+4);
  }
 s[i].write(a[i]);
  delay(15);
}

    pinMode(12, OUTPUT);
      pinMode(13, INPUT);
delay(1000);
} 
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/ 

void loop() 
{ 
  
   long duration, inches, cm;
  digitalWrite(12, LOW);
  delayMicroseconds(2);
  digitalWrite(12, HIGH);
  delayMicroseconds(5);
  digitalWrite(12, LOW);
   duration = pulseIn(13, HIGH);
     cm = microsecondsToCentimeters(duration);
    Serial.print(cm);
  Serial.print("cm");
  Serial.println();
  if (Serial.available() > 0) 
    {string = "";}
    
    while(Serial.available() > 0)
    {
      command = ((byte)Serial.read());
      
      if(command == ':')
      {
        break;
      }
      
  else
    {
      string += command;
    }     
      delay(1);
    }
    
  if(string == "TO")
    {
      con=1;
    }
    
  else if(string =="TF")
    {
      con=0;
    }
  else
    {
    }
     
    // chech the condition for different movement of the robot
  if(con=0)
    {
      rest();
      delay(10);
    }    
  else if(string =="rr")
    {
      rotater(); 
    }
  else if(string =="rl")
    {
      rotatel();
    }
  else if(string =="b")
    {
      
        front();
      
    }
  else if(string =="f")
    {  
      if(cm>20)
      { 
        left();
        }
      else
      {
        for(int cnt=0;cnt<4;cnt++)
        {
          front();
        }
        for(int cnt=0;cnt<4;cnt++)
        {
          rotater();
        }
        rest();
      }  
    }
  else if(string =="l")
    {
      left();
    }
  else if(string =="r")  
    {
      right();
    }
  else
    {
    }
    
  //if ((string.toInt()>=0)&&(string.toInt()<=255))
  //  {
   //    dl=map(string.toInt(),0,255,80,300);
  // }
   // else 
   // {
   //   dl=200;
  //  }
} 

/*#################################################*/




void rest()
{
for(int i=0;i<8;i++)
{
 s[i].write(a[i]);
  delay(15);
}
delay(1000);
}

void front()
{                    // first sequence
  s[1].write(a[1]-e2);
  s[5].write(a[5]-e2);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e2);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
}



void back()
{                    // first sequence
  s[1].write(a[1]-e2);
  s[5].write(a[5]-e2);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e2);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
}



void left()
{
                        // first sequence
  s[1].write(a[1]-e2);
  s[5].write(a[5]-e2);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e2);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
}

void right()
{                       // first sequence
  s[1].write(a[1]-e2);
  s[5].write(a[5]-e2);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e2);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
}

void rotatel()
{             // first sequence
  s[1].write(a[1]-e1);
  s[5].write(a[5]-e1);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
  

  s[0].write(a[0]);
  s[2].write(a[2]);
  s[4].write(a[4]);
  s[6].write(a[6]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e1);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
  

  s[0].write(a[0]);
  s[2].write(a[2]);
  s[4].write(a[4]);
  s[6].write(a[6]);
  delay(dl);
}


void rotater()
{             // first sequence
  s[1].write(a[1]-e1);
  s[5].write(a[5]-e1);
  delay(dl);
  s[0].write(a[0]-e2);
  s[2].write(a[2]+e2);
  s[4].write(a[4]-e2);
  s[6].write(a[6]+e2);
  delay(dl);
  s[1].write(a[1]);
  s[5].write(a[5]);
  delay(dl);
  

  s[0].write(a[0]);
  s[2].write(a[2]);
  s[4].write(a[4]);
  s[6].write(a[6]);
  delay(dl);
                        //second sequence
  s[3].write(a[3]-e1);
  s[7].write(a[7]-e2);
  delay(dl);
  s[0].write(a[0]+e2);
  s[2].write(a[2]-e2);
  s[4].write(a[4]+e2);
  s[6].write(a[6]-e2);
  delay(dl);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
  

  s[0].write(a[0]);
  s[2].write(a[2]);
  s[4].write(a[4]);
  s[6].write(a[6]);
  delay(dl);
}


void tilt1()
{/*
                          // first sequence
  s[1].write(a[1]+e1);
  s[3].write(a[3]-e1);
  s[5].write(a[5]-e1);
  s[7].write(a[7]+e1);
  delay(dl);
   delay(1000);*/
                        // first sequence
  s[1].write(a[1]-e1);
  s[3].write(a[3]-e1);
  s[5].write(a[5]);
  s[7].write(a[7]);
  delay(dl);
   delay(50);
   
   s[1].write(a[1]);
  s[3].write(a[3]-e1);
  s[5].write(a[5]-e1);
  s[7].write(a[7]);
  delay(dl);
   delay(50);
   
   s[1].write(a[1]);
  s[3].write(a[3]);
  s[5].write(a[5]-e1);
  s[7].write(a[7]+e1);
  delay(dl);
   delay(50);
   
   s[1].write(a[1]+e1);
  s[3].write(a[3]);
  s[5].write(a[5]);
  s[7].write(a[7]+e1);
  delay(dl);
   delay(50);   
  s[1].write(a[1]);
  s[5].write(a[5]);
  s[3].write(a[3]);
  s[7].write(a[7]);
  delay(dl);
   delay(50);
}


long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}
