#SensorTape Project 

##Introduction 
SensorTape is a sensor network in a form factor of a tape. It allows users to intuitively create large sensor networks. See mode details in the paper from UIST conference and a video 
This repository contains all the hardware and software design files to make SensorTape. 

##Content
*Master_hw/ - Hardware files for the master board in Altium format. Can be used to make the board

*Slave_hw/ - Hardware files for the tape itself, refered here as the slave. This is the flexible circuit version of the tape 

*Prog_adapter_hw/ -  Hardware files for the programming board, use it to program both the slave and the master. 

*libraries/ - Collection of the Arduino libraries for the master and the slave. Those libraries are required 

*Software/ - Firmware for both the master and the slave

*SensorTape_Sensor_Demo_V1/ - Processing sketch for a simple visualization demo. Demonstrates the basics of interfacing with a PC. 


##Slave 

##Master

![MediaLab Logo](/images/logo.png)
Format: ![Alt Text](url)


##Known Issues
1. Proximity sometimes dont work if tape is restarted. I suspect that they don't have time to fully discharge. When turning the tape on and off or restarting, wait some time to turn it back on. 
2. 


##Aknowledgements
MIT Media Lab, Nan-Wei Gong, Cindy Kao, Nan Zhao, Felix Heibeck, National Sceince Foundation. 