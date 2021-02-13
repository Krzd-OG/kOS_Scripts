CLEARSCREEN.

//Make user-input-able later
SET plannedApo TO 80000.
SET plannedPeri TO 80000.
SET inclanation TO 0.
SET plannedHeading TO 90. //calculate from inclanation

//=== === === STUFF === === ===

//IF ALREADY IN FLIGHT, SKIP THE COUNTDOWN
//Get Mission time? -> Workaround Get ALTITUDE?
IF SHIP:ALTITUDE < 100 {
  countdown().
} ELSE {
  PRINT "COUNTDOWN SKIPPED!".
}.

WAIT UNTIL SHIP:ALTITUDE > 1000.
LOCK THROTTLE TO 0.8.

//Staging command when 0 thrust is detected
WHEN MAXTHRUST = 0 AND THROTTLE > 0.0 THEN {
  PRINT "Staging..." AT(5,0).
  LOCK STEERING to SHIP:PROGRADE:VECTOR.
  RCS ON.
  STAGE.
  WAIT 1.
  RCS OFF.
  PRINT "          " AT(5,0). //remove "Staging" output
  PRESERVE. //Keep checking this statement even after executing it once.
}.

//WAIT UNTIL SHIP:ALTITUDE > 10000.
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90,90). //Locks steering to Heading+Degrees above horizon


//=== === === FUNCTIONS === === ===

FUNCTION countdown {
  PRINT "COUNTDOWN INITIALIZED".
  PRINT "...10".
  WAIT 1.
  PRINT "... 9 - Locking Steering".
  LOCK STEERING TO HEADING(90,90).
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
}.

FUNCTION gravityTurn {
  //Acent profile control
  PRINT "Engaging GravityTurn" AT(0,1).
  UNTIL SHIP:APOAPSIS > plannedApo {
    IF SHIP:APOAPSIS > 70000 AND SHIP:APOAPSIS < plannedApo AND SHIP:PERIAPSIS < plannedPeri {
      LOCK STEERING TO HEADING(90,-5).
      PRINT "Heading set to 90,-5" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 200 AND SHIP:VELOCITY:SURFACE:MAG < 300 {
      //Sets heading if inside specific velocity-above-surface range
      LOCK STEERING TO HEADING(90,80).
      PRINT "Heading set to 90,80" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 300 AND SHIP:VELOCITY:SURFACE:MAG < 400 {
      LOCK STEERING TO HEADING(90,70).
      PRINT "Heading set to 90,70" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 400 AND SHIP:VELOCITY:SURFACE:MAG < 500 {
      LOCK STEERING TO HEADING(90,60).
      PRINT "Heading set to 90,60" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 500 AND SHIP:VELOCITY:SURFACE:MAG < 600 {
      LOCK STEERING TO HEADING(90,50).
      PRINT "Heading set to 90,50" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 600 AND SHIP:VELOCITY:SURFACE:MAG < 700 {
      LOCK STEERING TO HEADING(90,40).
      PRINT "Heading set to 90,40" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 700 AND SHIP:VELOCITY:SURFACE:MAG < 800 {
      LOCK STEERING TO HEADING(90,30).
      PRINT "Heading set to 90,30" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 800 AND SHIP:VELOCITY:SURFACE:MAG < 900 {
      LOCK STEERING TO HEADING(90,20).
      PRINT "Heading set to 90,20" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 900 AND SHIP:ALTITUDE > 50000 {
      LOCK STEERING TO HEADING(90,0).
      PRINT "Heading set to 90,0" AT(0,2).
    }.
  }.
  CLEARSCREEN.
}.

FUNCTION orbitalInjection {
  PRINT "Engaging Orbital injection" AT(0,1).
  UNTIL SHIP:PERIAPSIS > plannedPeri {
    //Do Orbit. Something with time to apo (TTA) vs. TTP
  }.
  CLEARSCREEN.
}.

WAIT UNTIL false.
CLEARSCREEN.
PRINT "EOF reached".
LOCK THROTTLE TO 0.
