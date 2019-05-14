-------------------------------------------------------
Course:     EEE4120F
Project:    Sea Sounds Data Caster
Group:      10
Members:    MTNELL004, SCHSTE054
Date:       14/05/2019
-------------------------------------------------------

Repository Description:

------------------------------------------------------
Docs:
------------------------------------------------------ 	

This folder contains a pdf of the final report

------------------------------------------------------
Output:
------------------------------------------------------

Contains example output audio files. It is also where any new audio will be placed if the transmitter program is run.

The folder will currently contain:
	- an example sound file called "example1.wav" which contains the message: "encode and decode test"
	- an example sound file called "example2.wav" which contains the message: "this project was lekker"

The results from the send program (explained below) will also appear in this program and will be called "encoded_data.wav"

------------------------------------------------------
Software:
------------------------------------------------------

SEND:

This folder contains the "send.m" and "receive.m" programs as well as all the auxiliary programs that these programs use. To run the code in MATLAB, navigate to this folder and run the following from the command window: 

					send(message_to_send);

For example: 	send("testing testing");

Do not use any capital letters or numbers when contracting a message because the HuffmanTree does not cater for that.

The audio file produces by the send function will be called "encoded_data.wav" and will be stored in the Output folder.

RECEIVE:

To test the receiver program, type the following in the command window:

					receive();

This program will get the .wav file called "encoded_data.wav" from the Output folder and will analyse and decode the message and print the message to the console screen.


