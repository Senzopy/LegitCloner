@echo off
setlocal enabledelayedexpansion

:: Configuration
set "requirementsFile=requirements.txt"
set "mainPythonScript=main.py"

:: Function to check for Python installation
:checkPython
echo Checking for Python...
timeout /nobreak /t 1 >nul

:: Check if Python is in the system PATH
python --version >nul 2>&1
if errorlevel 1 (
    cls
    echo Python is not installed or not found in your system PATH.
    echo Please download and install Python from the following URL:
    echo https://www.python.org/downloads
    pause
    goto end
) else (
    cls
    echo Python is installed.
    python --version
)

:: Install requirements
echo Installing requirements from "%requirementsFile%"...
python -m pip install -r "%requirementsFile%"
if errorlevel 1 (
    cls
    echo Failed to install requirements. Please check your internet connection and try again.
    pause
    goto end
)

:: Run the Python script
echo Running the Python script "%mainPythonScript%"...
if exist "%mainPythonScript%" (
    python "%mainPythonScript%"
    if errorlevel 1 (
        cls
        echo Failed to run the Python script. Check the script for errors.
        pause
    ) else (
        cls
        echo Python script executed successfully.
    )
) else (
    cls
    echo The Python script "%mainPythonScript%" was not found in the current directory.
    echo Please check the script path and file name.
    pause
)

:end
endlocal
