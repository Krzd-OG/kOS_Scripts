CLEARSCREEN.

PRINT "COUNTDOWN INITIALIZED".
PRINT "...10".
WAIT 1.
PRINT "... 9 - Locking SAS".
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

PRINT "========== LIFTOFF! ==========".
WAIT 1.
CLEARSCREEN.

WAIT UNTIL SHIP:ALTITUDE > 1000.
LOCK THROTTLE TO 0.8.

WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    WAIT 0.5.
    PRESERVE. //Keep checking this statement even after executing it once.
}.

WAIT UNTIL SHIP:ALTITUDE > 10000.
LOCK THROTTLE TO 1.0.

WAIT UNTIL SHIP:ALTITUDE > 70000.
