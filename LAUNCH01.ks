CLEARSCREEN.

//Make user-input-able later
SET plannedApo TO 80000.
SET plannedPeri TO 80000.
SET inclanation TO 0.
SET plannedHeading TO 90. //calculate from inclanation

//=== === === MAIN === === ===

SET VARsteering TO SHIP:FACING. //set onto current heading

//IF ALREADY IN FLIGHT, SKIP THE COUNTDOWN
IF SHIP:ALTITUDE < 100 { //Launch pad ALTITUDE is around 80m
  countdown().
} ELSE {
  PRINT "COUNTDOWN SKIPPED!".
  LOCK STEERING TO VARsteering.
}.

//Staging command when 0 thrust is detected
WHEN MAXTHRUST = 0 AND THROTTLE > 0.0 THEN {
  PRINT "Staging..." AT(5,0).
  SET VARsteering TO SHIP:PROGRADE:VECTOR.
  RCS ON.
  STAGE.
  WAIT 0.5.
  RCS OFF.
  PRINT "          " AT(5,0). //remove "Staging" output
  IF SHIP:STAGENUM > 1 {
    PRESERVE. //Keep checking this statement even after executing it once.
  }.
}.

WHEN SHIP:ALTITUDE > 60000 THEN {
  PRINT "Deploying Solar Panels and Antennas".
  AG9 on. //when in vacuum, toggle ActionGroup 9 (Fairing, SolarPanel, and Antenna deployment)
}.

PRINT "Proceding until above 200 m...".
WAIT UNTIL SHIP:ALTITUDE > 200.
LOCK VARsteering TO HEADING(90,90). //rotate to prepare for gravity turn
LOCK THROTTLE TO 0.875.
CLEARSCREEN.

gravityTurn().
UNLOCK HEADING.

orbitalInjection().


//=== === === FUNCTIONS === === ===

FUNCTION countdown {
  PRINT "COUNTDOWN INITIALIZED".
  PRINT "...10".
  WAIT 1.
  PRINT "... 9 - Locking Steering".
  LOCK STEERING TO VARsteering.
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
      SET VARsteering TO HEADING(90,0).
      PRINT "Heading set to 90,0" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 100 AND SHIP:VELOCITY:SURFACE:MAG < 200 {
      //Sets heading if inside specific velocity-above-surface range
      SET VARsteering TO HEADING(90,85).
      PRINT "Heading set to 90,85" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 200 AND SHIP:VELOCITY:SURFACE:MAG < 300 {
      SET VARsteering TO HEADING(90,80).
      PRINT "Heading set to 90,80" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 300 AND SHIP:VELOCITY:SURFACE:MAG < 400 {
      SET VARsteering TO HEADING(90,70).
      PRINT "Heading set to 90,70" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 400 AND SHIP:VELOCITY:SURFACE:MAG < 500 {
      SET VARsteering TO HEADING(90,60).
      PRINT "Heading set to 90,60" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 500 AND SHIP:VELOCITY:SURFACE:MAG < 600 {
      SET VARsteering TO HEADING(90,50).
      PRINT "Heading set to 90,50" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 600 AND SHIP:VELOCITY:SURFACE:MAG < 700 {
      SET VARsteering TO HEADING(90,40).
      PRINT "Heading set to 90,40" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 700 AND SHIP:VELOCITY:SURFACE:MAG < 800 {
      SET VARsteering TO HEADING(90,30).
      PRINT "Heading set to 90,30" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 800 AND SHIP:VELOCITY:SURFACE:MAG < 900 {
      SET VARsteering TO HEADING(90,20).
      PRINT "Heading set to 90,20" AT(0,2).
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG > 900 AND SHIP:ALTITUDE > 50000 {
      SET VARsteering TO HEADING(90,0).
      PRINT "Heading set to 90,0" AT(0,2).
    }.
  }.
  CLEARSCREEN.
}.

FUNCTION orbitalInjection {
  PRINT "Engaging Orbital injection" AT(0,1).
  UNTIL SHIP:PERIAPSIS > plannedPeri {
    //Need to figure out the order of this out
    LOCK THROTTLE TO 0.0.
    IF SHIP:OBT:ETA:APOAPSIS > SHIP:OBT:ETA:PERIAPSIS AND SHIP:PERIAPSIS < 70000 { //missed the APOAPSIS! (both return time in seconds)
      PRINT "Missed the APOAPSIS, Emergency correction Burn commencing".
      UNTIL SHIP:PERIAPSIS > 70000 {
        RCS ON.
        SET VARsteering TO HEADING(90,20). //WHY ARE YOU NOT WORKING??
        WAIT 0.2.
        LOCK THROTTLE TO 1.0.
        WAIT 0.
      }.
    }.
    RCS OFF.
    WAIT 0.1. //to keep it from endlessly looping and just destroying performance
  }.
  //drift until ((whatever dV needed to get PERIAPSIS above 70000)/MAXTHRUST) before APOAPSIS

  CLEARSCREEN.
}.

WAIT UNTIL false.
CLEARSCREEN.
PRINT "EOF reached".
LOCK THROTTLE TO 0.
