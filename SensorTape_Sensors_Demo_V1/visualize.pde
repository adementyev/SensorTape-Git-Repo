import java.text.DecimalFormat;

public class visualize {
  private PApplet applet;
  
  public visualize(PApplet _applet) {
    applet = _applet;
  }
  
  public void drawSensors(ArrayList <sensorNode>listSensors, int type) { 
      for (int i = 0; i<listSensors.size(); i++) { 
        drawOneSensor(i, listSensors.get(i).getLatest(), type,listSensors.get(i).getTurn(), 
            listSensors.get(i).getXPosition(), listSensors.get(i).getYPosition());
      }//end for  
  }
  
  public void drawOneSensor(int position, int[] data, int type, int orientation, int xpos,int ypos ) { 
    
      //---------Visualize light sensor---------
      if (type ==1 && data.length>7) {
        fill(data[1],0,0); 
        rect(xpos,ypos, 60,60); 
        textSize(15);
        text("Light Sensor", 100, 200);
      }   
      //---------Visualize proximity---------
      if (type ==2 && data.length>7) { 
        fill(0,0,data[3]); 
        text(data[3] +" mm", xpos, ypos);
        rect(xpos,ypos, 60,60); 
        text("Proximity Sensor", 100, 200);
      }
      
      //---------Visualize IMU data, in quaternion format---------
      if (type==3 && data.length>7) { 
        text(data[4], xpos, ypos);
        text(data[5], xpos, ypos-20);
        text(data[6], xpos, ypos-40);
        text(data[7], xpos, ypos-60);
        fill(128);
        rect(xpos,ypos, 60,60);   
        text("IMU Sensor", 100, 200);
      }
      //---------Visualize temperature---------
      if (type==4 && data.length>7) { 
        //does not convert it right, needs better calibration
        text(convertToTemperature(data[2]) + " C",xpos, ypos);
        fill(128);
        rect(xpos,ypos, 60,60);   
        text("Temperature Sensor", 100, 200);
      } 
  }//end drawOneSensor
  
   String convertToTemperature(int RawADC) {
     double Temp;
     Temp = applet.log((float) (10000.0*((1024.0/RawADC-1)))); 
//             =log(10000.0/(1024.0/RawADC-1)) // for pull-up configuration
     Temp = 1 / (0.001129148 + (0.000234125 + (0.0000000876741 * Temp * Temp ))* Temp );
     Temp = Temp - 273.15;            // Convert Kelvin to Celcius
    // Temp = (Temp * 9.0)/ 5.0 + 32.0; // Convert Celcius to Fahrenheit
    DecimalFormat df = new DecimalFormat("#.0");
    String formatedString = df.format(Temp);          
    return formatedString;
   }//end covertToTemperature
}