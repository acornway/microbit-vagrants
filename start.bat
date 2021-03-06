@ECHO ON
vagrant plugin install vagrant-auto_network
@ECHO OFF
ECHO -----------------------------------------
ECHO Welcome to the microbit-vagrants control.
ECHO -----------------------------------------
ECHO 1 - Espruino
ECHO 2 - MicroPython
ECHO 3 - RIOT-OS Environment
ECHO 4 - PXT
ECHO 5 - Exit
SET /P C=Type the number you want from above then press enter: 
IF %C%==1 GOTO ESPRUINO
IF %C%==2 GOTO MICROPYTHON
IF %C%==3 GOTO RIOT
IF %C%==4 GOTO PXT
IF %C%==5 EXIT

:ESPRUINO
@ECHO ON
cd Espruino
vagrant up
@ECHO OFF
SET /P Z=
EXIT
:MICROPYTHON
@ECHO ON
cd micropython
vagrant up
@ECHO OFF
SET /P Z=
EXIT
:RIOT
@ECHO ON
cd RIOT
vagrant up
@ECHO OFF
SET /P Z=
EXIT
:PXT
@ECHO ON
cd PXT
vagrant up
@ECHO OFF
SET /P Z=
EXIT
