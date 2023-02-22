@echo off
echo Fix GBS Bank brand for MSEdge 100.0.XXXX.XXX
echo.
pause
echo.
echo *** DOWNLOADING MSEDGE 97.0.1072.55...
mkdir c:\gbs_fix
timeout 2 > nul
curl.exe -o c:\gbs_fix\microsoft-edge-97-0-1072-55.msi https://mirror.kraski.tv/soft/edge_chromium/windows/97.0.1072.55/MicrosoftEdgeEnterpriseX64_97.0.1072.55.msi

echo.
echo ** NOW CHECK MSEDGE VERSION....
timeout 2 > nul
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\102.0.1245.30" (
	echo confirm, current version is 102.0.1245.30
	goto UninstallEdge
) else (
	echo oh, no - you have other version?
	echo.
	pause
	exit
)
:UninstallEdge
timeout 2 > nul
echo.
echo ***OK, LETS TRY TO UNINSTALL CURRENT MSEDGE VERSION...
cd C:\Program Files (x86)\Microsoft\Edge\Application\102.0.1245.30\Installer
if exist setup.exe (
	setup.exe --uninstall --system-level --verbose-logging --force-uninstall
) else (
	echo.
	echo not found msedge, probably uninstalled!
)
timeout 5 > nul
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\102.0.1245.30\msedge.exe" (
	echo.
	echo oh, no! i cannot remove msedge...cmd
	pause
	exit
) else (
	echo.
	echo yupi!, edge is uninstall successfully.
	goto DowngradeEdge
)
:DowngradeEdge
timeout 2 > nul
echo.
echo *** OK, SO NOW RUN INSTALLER MSEDGE 97.0.1072.55...
start c:\gbs_fix\microsoft-edge-97-0-1072-55.msi
echo.
echo *** press any key when installer done job to continue... 
pause > nul
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\97.0.1072.55\msedge.exe" (
	echo.
	echo ok, downgrade complete!
	goto DisableAutoUpdateEdge
) else (
	echo.
	echo oh, no! downgrade fail
	pause
	exit
)
:DisableAutoUpdateEdge
echo.
echo *** OK, LAST ONE TO DO IS DISABLE AUTO UPDATE MSEDGE...
timeout 2 > nul
echo.
echo step 1 - disable update service...
sc config MicrosoftEdgeElevationService start= disabled
echo.
echo step 2 - remove update task scheduled...
timeout 2 > nul
schtasks /Delete /TN "MicrosoftEdgeUpdateTaskMachineUA" /F
schtasks /Delete /TN "MicrosoftEdgeUpdateTaskMachineCore" /F
echo.
echo step 3 - rename updater file...
timeout 2 > nul
if exist "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" (
	echo found MSedge updater, rename to _bak.exe 
	rename "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" MicrosoftEdgeUpdate_bak.exe
) else (
	echo not found MSedge updater, fail exit...
	pause
	exit
)
echo. 
echo.
if exist "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate_bak.exe" (
	echo ALL DONE!
) else (
	echo cannot rename updater...
)
echo.
pause