@echo off
setlocal

set VMNAME=WS_RAM_win

vboxmanage list runningvms | findstr /C:"%VMNAME%" >nul
if %errorlevel% equ 0 (
    echo VM "%VMNAME%" is currently running.
) else (
    echo VM "%VMNAME%" is not running. Checking if VM exists.
    
    vboxmanage startvm  "%VMNAME%"
)

endlocal
pause