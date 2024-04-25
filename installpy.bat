@echo off
powershell -Command "curl -o python-installer.exe https://www.python.org/ftp/python/3.9.9/python-3.9.9-amd64.exe"
powershell -Command "python-installer.exe /passive InstallAllUsers=1 PrependPath=1 Include_test=0"
