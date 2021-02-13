CLEARSCREEN.

//Things to add:

//Time to APOAPSIS
//Time to PERIAPSIS
//inclanation(?)
//RCS fuel % left
//stage fuel % left (maybe)
//dV vacuum, deep space



//Telemetry view
PRINT "ALTITUDE:" AT (0,2).
PRINT "APOAPSIS:" AT (0,3).
PRINT "PERIAPSIS:" AT (0,4).
PRINT "STAGE dV:" AT (0,5).
PRINT "Current MASS:" AT (0,6).
PRINT "Dry MASS:" AT (0,7).

UNTIL false {
  PRINT SHIP:NAME AT (15,0).
  PRINT ROUND(SHIP:ALTITUDE,0) AT (15,2).
  PRINT ROUND(SHIP:APOAPSIS,0) AT (15,3).
  PRINT ROUND(SHIP:PERIAPSIS,0) AT (15,4).
  SET stageDV TO SHIP:STAGEDELTAV(SHIP:STAGENUM):CURRENT.
  PRINT stageDV AT (15,5).
  PRINT ROUND(SHIP:MASS,0) AT (15,6).
  PRINT ROUND(SHIP:DRYMASS,0) AT (15,7).
  WAIT 0.
}
