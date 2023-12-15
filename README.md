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
For the Finite State Machine (FSM) we had to make this entirly on our own using no code from prevoius labs or exams. We used 4 states which include Start, Check, Note, and Done. Start will go to Check if our Start switch is on but otherwise stay in Start. Once we are in Check we are checking to see if our song has finished using the if statment. If it is not finished we continue to our Note state where if we pressed the correspoding button based of the random number generation then we gain a point and head back to check. Should we not hit the correct button we lose a pint and again go back to check. Finally if the song duration is up then we go to a done state.

#### Delay
After we created the FSM we realized we would need a delay module to prevetn double reading from happening while playing the game. We did this by creating a clock module that tick every one second and then initializing it inside our FSM to create a delay.

## Video


## Conclusion
With more time we would hope to expand on certain functions of our game and make it more advanced. Our project took us about 20 hours of work and we would have liked to do more but time was not on our side. Some ideas we would've liked to add were a VGA module and song tempo to make the game more like Gutair Hero. Another idea we had was to conntect a original Gutiar Hero gutair controller to have correspond to the notes you should hit. Our repository holds the Verilog programs that were used to create our game, a high level description of what each module does, a video of our team playing the game, and pictures of the different screens that appear throughout the game.

