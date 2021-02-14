CLEARSCREEN.

//Things to add:

//Time to APOAPSIS
//Time to PERIAPSIS
//inclanation(?)
//RCS fuel % left
//stage fuel % left (maybe)
//dV vacuum, deep space



//Telemetry view


UNTIL false {
  CLEARSCREEN. //clean up old numbers
  printLables().
  PRINT SHIP:NAME AT (20,0).
  PRINT ROUND(SHIP:ALTITUDE,0) AT (16,2).
  PRINT ROUND(SHIP:APOAPSIS,0) AT (16,3).
  PRINT ROUND(SHIP:PERIAPSIS,0) AT (16,4).
  SET stageDV TO SHIP:STAGEDELTAV(SHIP:STAGENUM):CURRENT.
  PRINT ROUND(stageDV,0) AT (16,5).
  PRINT ROUND(SHIP:MASS,0) AT (16,6).
  WAIT 0.
}

FUNCTION printLables {
  PRINT "ALTITUDE:" AT (0,2).
  PRINT "APOAPSIS:" AT (0,3).
  PRINT "PERIAPSIS:" AT (0,4).
  PRINT "STAGE dV in m/s:" AT (0,5).
  PRINT "MASS in t:" AT (0,6). //maybe broken?
}
