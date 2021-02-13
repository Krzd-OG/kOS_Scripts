//This file will be launched once any vessel loads for the first time
//Option to either output Telemetry or a Launch Program (T vs L01/L02/etc.)

WAIT UNTIL SHIP:UNPACKED.
CLEARSCREEN.
PRINT "Please select which file to load onto this CPU:"
//SET userInput TO //put input here

IF userInput = "T" {
  COPYPATH ("0:/TELEMETRY01","").
  RUN TELEMETRY01.
} ELSE IF userInput = "L01" {
  COPYPATH ("0:/LAUCH01","").
  RUN LAUNCH01.
} ELSE IF userInput = "EXM1" {
  COPYPATH ("0:/EXAMPLE01","").
  RUN EXAMPLE01.
}.
