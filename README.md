#SensorTape Project 
![MediaLab Logo](/images/logo.png)

##Introduction 
SensorTape is a sensor network in a form factor of a tape. It allows users to intuitively create large sensor networks. See mode details in the paper from UIST conference and a video 
This repository contains all the hardware and software design files to make SensorTape. 

##Content
Master_hw/ - Hardware files for the master board in Altium format. Can be used to make the board

Slave_hw/ - Hardware files for the tape itself, refered here as the slave. This is the flexible circuit version of the tape 

Prog_adapter_hw/ -  Hardware files for the programming board, use it to program both the slave and the master. 

libraries/ - Collection of the Arduino libraries for the master and the slave. Those libraries are required 

Software/ - Firmware for both the master and the slave

SensorTape_Sensor_Demo_V1/ - Processing sketch for a simple visualization demo. Demonstrates the basics of interfacing with a PC. 

SensorTape_3D_Demo_V1/ - Processing sketch for the 3D surface reconstruction with IMUs and NURBs curves for a PC 

##Firmware 
Add the arduino libraries from the libraries/ folder here to the worspace libraries folder. 
You will need the following libraries Adafruit_NeoPixel, I2C_dev, MPU6050, and VL6180X_I2C_Soft

you will need a programmer and an adapter board (Prog_adapter_hw/) to load the software. I used AVRISP mKII.
you will need to load the bootloader first into the boards. This will set the fuses and the clock frequency. Use the Arduino Micro (3.3V, 8 MHz) for the slaves and Arduino leonardo for the master. Set those before loading the bootloader

##PC software
I used Processing 3. You will need one external library (toxiclibs-complete-0020)

##Slave 


##Master



##Known Issues
1. Proximity sometimes dont work if tape is restarted. I suspect that they don't have time to fully discharge. When turning the tape on and off or restarting, wait some time to turn it back on. 
2. 


##Aknowledgements
MIT Media Lab, Nan-Wei Gong, Cindy Kao, Nan Zhao, Felix Heibeck, National Sceince Foundation. 