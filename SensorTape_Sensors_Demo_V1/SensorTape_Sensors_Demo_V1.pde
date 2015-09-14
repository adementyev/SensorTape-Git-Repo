/*
SensorTape Sensor Demo V1
This is a simple Processing 3 visualization program for the sensor nodes.
It is used to demonstrate the basics of interfacing with sensor nodes
There is a seperate program, used for 3D visualization stuff
The number of nodes is programmatically set at the start, this simplified development, so all the nodes don't need to be 
reset when program is restarted. 
I recommend using Eclipse Java for more serious development. On the downside it is harder to setup Eclipse, especially the serial drivers 
There will be eclipse Version of this program. 

Press 1 to visualize light sensor
Press 2 to visualize proximity
Press 3  to visualize IMU data
Press 4 to visualize temperature
Press 5 to cycle blue/red on the first node

Known issues in this version: 
1) Temperature conversion is not correct
2) Orientation is ignored here. There are two cuts on each node that can determine the orientation
3) 

Created by Artem Dementyev
Modified on September 14, 2015
*/

import processing.serial.*;

Serial myPort;        // The serial port 
boolean start = true; 
int deviceID = 0; 
int deviceCounter = 1;
sensorNode[] tempArraySensors = new sensorNode[128];
ArrayList <sensorNode>listSensors = new ArrayList<sensorNode>(); 
visualize drawStuff = new visualize(this);
boolean orientationFlag = true; 
int visualizeSensorType = 1;

void setup()
{
   size(1850, 1000, P3D); // animation is much smoother in P2D; text looks better with JAVA2D
   background(255);
   
   //Find serial port
    for (int i=0; i<Serial.list().length; i++) { 
      System.out.println(i + " : " + Serial.list()[i]); 
    }//end for
    myPort = new Serial(this, Serial.list()[0], 115200);
    
    //Use this code to declare the nodes at the start. Avoid needing a restart every time rerunning the program, a lot faster for development
    int numberOfNodes = 12;
    int [] cuts = {0,0,0,0};  
    for (int i=1; i<numberOfNodes+1; i++) { 
      sensorNode tempSensorNode = new sensorNode(i, 3, 1, cuts );   
      listSensors.add(tempSensorNode);  
    }//end for
    frameRate(30);
}//end setup

void draw() { 
      smooth();
      background(255);
      
      if(!start) { 
          drawStuff.drawSensors(listSensors,visualizeSensorType);       
      }//end if
   
      if (!start && orientationFlag) {
        determineOrientation(); 
        orientationFlag = false; 
      }//end if
}//end draw

 public void serialEvent (Serial myPort) {
     try {     //Use try, catch to avoid crashing
       // get the ASCII string:
       String inString = myPort.readStringUntil('\n');   
      
       //Check if the string is good
       //I use the 'S' character at the beggining
       //Otherwise, I get a null point, and computer may crash (MAC 10.6)
       if (inString != null && inString.charAt(0) == 'A' && start) {
         System.out.println(inString);
         inString = trim(inString);
         String[] list = split(inString, ',');
         if(list.length == 8 ) {
           deviceID = Integer.parseInt(list[1]);
           if (Integer.parseInt(list[1]) == deviceCounter) {
             System.out.println("Found: " + Integer.toString(deviceCounter));
             
            // int [] cuts = {Integer.parseInt(list[4]),Integer.parseInt(list[5]),Integer.parseInt(list[6]),Integer.parseInt(list[7])};                    
      
             //TODO NOW Declaring a fake sensor node, has to fix the restart problem 
             int [] _cuts = {0,0,0,0};  
             sensorNode tempSensorNode = new sensorNode(Integer.parseInt(list[1]), 
                 3, 1, _cuts );        
             listSensors.add(tempSensorNode);      
             }         
         }
         deviceCounter++;
       }//end if start
       
       //This is the normal data 
       else if (inString != null && inString.charAt(0) == 'S' && listSensors.size()>0) {
         start = false;
         // trim off any whitespace:
         System.out.println(inString);
         inString = trim(inString);
         String[] list = split(inString, ',');
                 
         if (list.length==9) { 
           sensorNode tempSensorNode = listSensors.get(Integer.parseInt(list[1])-1);
           int tempInput[]; 
           tempInput = new int [list.length-1];
           for (int i =1; i<list.length; i++) { 
             tempInput[i-1] = Integer.parseInt(list[i]); 
           }//end if        
     
           tempSensorNode.addData(tempInput);  
           listSensors.remove(Integer.parseInt(list[1])-1);
           listSensors.add(Integer.parseInt(list[1])-1,tempSensorNode );           
         }//end if list length is correct
       }//end if String is correct     
      } catch (Exception e){ 
        System.out.println("Error: " + e);
      }  
}//end SerialEvent

public void changeLEDColor( int node,byte command1, byte command2, byte command3) {
    //nice page explaining: 
    //http://blog.danielkerris.com/?p=349     
    myPort.write((char)(node/256));
    myPort.write(node & 0xff);
    myPort.write(command1);
    myPort.write(command2);
    myPort.write(command3); 
    
}//end changeLEDCOlor

//Press keys to change visualization 
public void keyPressed() {
    //visualize light sensors
    if (key == '1') 
      visualizeSensorType=1;
    //visualize proximity sensors
    else if (key == '2')
      visualizeSensorType=2;
    //visualize orientation sensors
    else if (key == '3')
      visualizeSensorType=3;
    else if (key == '4')
      visualizeSensorType=4;
    else if (key =='5') { 
      byte a = 0; 
      byte b = 0; 
      byte c = 100; 
      changeLEDColor(1,a,b,c);
    }
    else if (key =='6') { 
      byte a = 100; 
      byte b = 0; 
      byte c = 0; 
      changeLEDColor(1,a,b,c);
    }
}//end keyPressed
   
 public void determineOrientation() {  
   //Initial x and y positions
    int xpos = 100; 
    int ypos = 300;
    //Assign positions to each node
    for (int i=0; i<listSensors.size(); i++ ) {                      
       xpos = xpos + 60;
       sensorNode tempSensorNode = listSensors.get(i);
       tempSensorNode.setPosition(xpos,ypos);  
       listSensors.remove(i);
       listSensors.add(i,tempSensorNode);    
    }//end for  
  }//end determineOrientation