@echo off
setlocal

set LINUX_VMNAME=WS_RAM_ubuntu
set WIN_VMNAME=WS_RAM_win

vboxmanage list runningvms | findstr /C:"%WIN_VMNAME%" >nul
if %errorlevel% equ 0 (
    echo VM "%WIN_VMNAME%" is currently running.
) else (
    echo VM "%WIN_VMNAME%" is not running. Checking if VM exists.
    
    vboxmanage startvm  "%WIN_VMNAME%"
)

vboxmanage list runningvms | findstr /C:"%LINUX_VMNAME%" >nul
if %errorlevel% equ 0 (
    echo VM "%LINUX_VMNAME%" is currently running.
) else (
    echo VM "%LINUX_VMNAME%" is not running. Checking if VM exists.
    
    vboxmanage startvm  "%LINUX_VMNAME%"
)

endlocal
pause