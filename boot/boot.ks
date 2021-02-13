//This file will be launched once any vessel loads for the first time.

displayOptions().
WAIT 0. //it's too fast for it's own good?
getUserInput().


//=== === === FUNCTIONS === === ===

FUNCTION displayOptions {
  CLEARSCREEN.
  PRINT "Please select which file to load onto this CPU:" AT (0,1).
  PRINT "Available Files:" AT (0,2).
  PRINT "1 - TELEMETRY01" AT (0,3).
  PRINT "2 - LAUCH01" AT (0,4).
  PRINT "3 - EXAMPLE01 - THIS DOES NOTHING AT THE MOMENT" AT (0,5).
}

FUNCTION getUserInput {
  SET userInput to "".
  WAIT 0.
  SET char TO TERMINAL:INPUT:GETCHAR().
  SET userInput TO userInput + char.

  IF TERMINAL:INPUT:ENTER { //doesn't wait for the ENTER?
    checkUserInput().
  }.
}.

FUNCTION checkUserInput {
  IF userInput = "T" {
    COPYPATH ("0:/TESTING","").
    CLEARSCREEN.
    PRINT "WARNING! NOW RUNNING TESTING.ks!" AT(10,25).
    WAIT 3.
    RUN TESTING.
  } ELSE IF userInput = "1" {
    COPYPATH ("0:/TELEMETRY01","").
    RUN TELEMETRY01.
  } ELSE IF userInput = "2" {
    COPYPATH ("0:/LAUNCH01","").
    RUN LAUNCH01.
  } ELSE IF userInput = "3" {
    //COPYPATH ("0:/EXAMPLE01","").
    //RUN EXAMPLE01.
  } ELSE {
    PRINT "User Input could not be recognized, please try again" AT (0,7).
    WAIT 2.
    CLEARSCREEN.
    displayOptions().
    getUserInput().
  }.
}.


PRINT "DEBUGGING: Exited loop, WHAT THE FUCK, HOW?" AT (0,25).
