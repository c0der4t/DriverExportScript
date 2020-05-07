@ECHO OFF
echo This Script Will Attempt to Export All Third-Party Drivers From This Machine.
echo =============================================================================================
echo PLEASE ENSURE YOU ARE RUNNING THIS SCRIPT AS ADMINISTRATOR
echo This may take a while depending on the speed and amount of drivers on the machine.
echo Note:
echo A Instructional Textfile (Instructions.txt) as well as a Driver Information Textfile (DriverInfo.txt)
echo will also be generated and placed inside the export folder.
pause
cls
echo Follow the prompts to export the drivers to a folder.
echo

:SetFolder
cls
set /P sBackupDir=Please Enter The Path to The Export Folder:

set /P bConfirm=Set Export Folder to %sBackupDir% (y/n):
if /I "%bConfirm%" EQU "Y" goto :StartExport
if /I "%bConfirm%" EQU "N" goto :SetFolder

:StartExport
if not exist %sBackupDir%\NUL mkdir %sBackupDir%
set InstructionFile=%sBackupDir%\Instructions.txt
goto :GenerateInstrutions
:CreateList
dism.exe /Online /Get-Drivers > %sBackupDir%\DriverInfo.txt
dism /online /export-driver /destination:%sBackupDir%
cls
echo Export Completed. Drivers Exported to %sBackupDir%
pause
exit
:GenerateInstrutions
echo How to Install Exported Drivers on a Different Machine: >> %InstructionFile%
echo 1 Boot into the copy of Windows where you want to install the exported drivers >> %InstructionFile%
echo 2 Navigate to the backup folder and find the folder for the driver that you want added to Windows >> %InstructionFile%
echo 3 Right-click the INF file and choose Install >> %InstructionFile%
goto :CreateList