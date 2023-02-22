@echo off
echo.
echo *** OK, last one is disbale auto update MSEDGE...
echo.
echo step 1 - disabale update service
sc config MicrosoftEdgeElevationService start= disabled

timeout 3 > nul
echo.
timeout 3 > nul
echo.
echo step 2 - remove update task scheduled...
schtasks /Delete /TN "MicrosoftEdgeUpdateTaskMachineUA" /F
schtasks /Delete /TN "MicrosoftEdgeUpdateTaskMachineCore" /F

echo.

timeout 3 > nul
echo step 3 - rename updater file
rename "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" MicrosoftEdgeUpdate_bak.exe
echo. 
echo.
echo DONE!
echo.
pause

::SUCCESS: The scheduled task "MicrosoftEdgeUpdateTaskMachineUA" was successfully deleted.