# Rhythm-Hero
Final Project for Dr. Jameison's ECE 287 section D
Authors: Sean Whyle and Samuel Shuman

## Project Description 
Our project is a Gutair Hero like game where you must press buttons based on a number that displays from a FPGA board's Seven Segment display. if you press the correct numbered button and the correct time then your score will increase by 2 points, should you press the incorrect button or at the wrong time then your score will decreasing by 2 points. Fianlly your score will be displayed using the Seven Segment portion of the FPGA baord

## Background Information

For our project we wanted to orginally implement the classic game Gutair Hero on the FPGA board but use a VGA driver to accomplish video needs; However towards the end we realize we might have biten off more than we could chew. As a result we settled a simipler version of the game where you must press the  certain keys at a certain time in order gain points, much like the orginal idea.

## Design
Below is chronologically listed the order that we created the different parts of our project.

#### Seven Segment Display
We used the code from prevoius labs to get the display output. We used seven segemnt to display what number button you sould hit as well as to display your score. This code was farily straight forwards and nothing had to be changed for it to fit our needs, argueablly the easist part of the project.

#### Random Generation
For this we used the code from Exam 4 provided by Dr. Jameison. This code is meant to generate a random number (0-3) which is then displayed on the seven segment. based on this number corresponds to which button should be pressed. Addtioanlly no code was changed for this fit our needs.

#### FSM
For the Finite State Machine (FSM) we had to make this entirly on our own using no code from prevoius labs or exams. 
