@echo off
echo Starting OpenRecon setup...

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed. Please install Python 3.8 or higher
    exit /b 1
)

REM Check if pip is installed
pip --version >nul 2>&1
if errorlevel 1 (
    echo pip is not installed. Please install pip
    exit /b 1
)

REM Install virtualenv if not installed
pip show virtualenv >nul 2>&1
if errorlevel 1 (
    echo Installing virtualenv...
    pip install virtualenv
)

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m virtualenv venv
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install requirements
echo Installing requirements...
pip install -r requirements.txt

REM Install the package in development mode
echo Installing OpenRecon in development mode...
pip install -e .

REM Install and setup Playwright
echo Installing Playwright...
pip install playwright
echo Installing Playwright browsers...
playwright install

REM Check if nmap is installed
where nmap >nul 2>&1
if errorlevel 1 (
    echo Please note: Nmap is required for some features.
    echo Download and install Nmap from: https://nmap.org/download.html#windows
)

REM Check for Microsoft Visual C++ Redistributable
echo Checking for Microsoft Visual C++ Redistributable...
reg query "HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" >nul 2>&1
if errorlevel 1 (
    echo Please note: Microsoft Visual C++ Redistributable might be required for Playwright.
    echo Download it from: https://aka.ms/vs/17/release/vc_redist.x64.exe
)

echo Setup completed successfully!
echo To activate the virtual environment in the future, run: venv\Scripts\activate.bat
pause 