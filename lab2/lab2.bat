echo off
cls
REM    
set p2=My_help.bat
set p1=no
REM  
if not (%1) ==() set p1=%1
if not (%2) ==() set p2=%2
if (%p1%) == (yes) cls
:menu
REM   
echo 1. Ŋā ĒŠ 
echo 2.  ã§ 
echo 3. DIR
echo 4. įĻáâĻâė íŠā ­
echo 5. ëåŪĪ
REM   
be ask "ëĄĨāĨâĨ Ŋã­Šâ (1,2,3,4,5)" '12345' default=2 timeout=10
REM 
if ERRORLEVEL 5 goto 5
if ERRORLEVEL 4 goto 4
if ERRORLEVEL 3 goto 3
if ERRORLEVEL 2 goto 2
if ERRORLEVEL 1 goto 1
goto menu
REM  
:1
echo 1
call %p2%
goto menu
REM 
:2
echo 2
pause
goto menu
REM  
:3
echo 3
DIR /b
pause
goto menu
REM   My_help
:4
echo 4
cls
pause
goto menu
REM 
:5
echo 5
goto fin
:fin
if %p1%==yes cls
exit
ECHO  ĒĨāčĨ­ĻĨ ŊāŪĢā ŽŽë 
