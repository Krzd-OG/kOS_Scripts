CLEARSCREEN.

PRINT "COUNTDOWN INITIALIZED".
PRINT "...10".
WAIT 1.
PRINT "... 9 - Locking Steering".
LOCK STEERING TO UP.
WAIT 1.

PRINT "... 8".
WAIT 1.
PRINT "... 7".
WAIT 1.
PRINT "... 6".
WAIT 1.
PRINT "... 5 - Locking minimum Throttle".
LOCK THROTTLE TO 0.2. //Lock throttle to 20%
WAIT 1.

PRINT "... 4".
WAIT 1.
PRINT "... 3 - Starting Engines".
STAGE.
WAIT 1.

PRINT "... 2 - Releasing Fuel connections".
STAGE.
WAIT 1.

PRINT "... 1 - Increasing Thrust".
LOCK THROTTLE TO 1.0.
WAIT 1.

PRINT "... 0 - Realeasing Launch clamps".
STAGE.
LOCK THROTTLE TO 1.0.

PRINT "".
PRINT "========== LIFTOFF! ==========".
WAIT 2.
CLEARSCREEN.

WAIT UNTIL SHIP:ALTITUDE > 1000.
LOCK THROTTLE TO 0.8.

WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    WAIT 0.5.
    PRESERVE. //Keep checking this statement even after executing it once.
}.

//WAIT UNTIL SHIP:ALTITUDE > 10000.
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90,90). //Locks steering to Heading+Degrees above horizon

UNTIL APOAPSIS > 75000 {
  IF SHIP:VELOCITY:SURFACE:MAG > 200 AND SHIP:VELOCITY:SURFACE:MAG < 300 {
    //Sets heading if inside specific velocity-above-surface range
    LOCK STEERING TO HEADING(90,80).
  } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 300 AND SHIP:VELOCITY:SURFACE:MAG < 400 {
    LOCK STEERING TO HEADING(90,70).
  } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 400 AND SHIP:VELOCITY:SURFACE:MAG < 500 {
    LOCK STEERING TO HEADING(90,60).
  }
}.


















WAIT UNTIL SHIP:ALTITUDE > 70000.
