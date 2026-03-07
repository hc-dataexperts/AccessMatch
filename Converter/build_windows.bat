@echo off
:: ============================================================
:: Hood College Coding Club — JSON Uploader Build Script
:: Double-click this file on Windows to build the installer.
:: Requirements: Python 3.9+ must be installed.
:: ============================================================

title Hood CC JSON Uploader — Build

echo.
echo  ==========================================
echo   Hood College Coding Club
echo   CSV/Excel to JSON Uploader — Builder
echo  ==========================================
echo.

:: ── Step 1: Check Python ──────────────────────────────────
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not on your PATH.
    echo         Download it from https://www.python.org/downloads/
    echo         Make sure to check "Add Python to PATH" during install.
    pause
    exit /b 1
)
echo [OK] Python found:
python --version

:: ── Step 2: Install/upgrade pip packages ─────────────────
echo.
echo [1/4] Installing required packages...
pip install --upgrade pip --quiet
pip install requests openpyxl pyinstaller --quiet
if errorlevel 1 (
    echo [ERROR] Failed to install packages. Check your internet connection.
    pause
    exit /b 1
)
echo [OK] Packages installed.

:: ── Step 3: Build exe with PyInstaller ───────────────────
echo.
echo [2/4] Building standalone .exe with PyInstaller...
echo       (This may take 1-3 minutes -- please wait)
echo.
python -m PyInstaller --noconfirm HoodCC_JSON_Uploader.spec
if errorlevel 1 (
    echo [ERROR] PyInstaller build failed. See error above.
    pause
    exit /b 1
)
echo.
echo [OK] Executable built: dist\HoodCC_JSON_Uploader.exe

:: ── Step 4: Check for Inno Setup ─────────────────────────
echo.
echo [3/4] Checking for Inno Setup...

set INNO_PATH=""
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    set INNO_PATH="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
) else if exist "C:\Program Files\Inno Setup 6\ISCC.exe" (
    set INNO_PATH="C:\Program Files\Inno Setup 6\ISCC.exe"
)

if %INNO_PATH%=="" (
    echo.
    echo [SKIP] Inno Setup not found — skipping installer creation.
    echo.
    echo  Your standalone .exe is ready at:
    echo    dist\HoodCC_JSON_Uploader.exe
    echo.
    echo  To create a full Windows installer (.exe setup file):
    echo    1. Download Inno Setup (free): https://jrsoftware.org/isinfo.php
    echo    2. Install it, then re-run this build script.
    echo.
    goto :done
)

echo [OK] Inno Setup found at: %INNO_PATH%
echo.
echo [4/4] Creating Windows installer...
mkdir installer_output 2>nul
%INNO_PATH% installer.iss
if errorlevel 1 (
    echo [ERROR] Inno Setup failed. See error above.
    pause
    exit /b 1
)
echo.
echo [OK] Installer created in: installer_output\

:done
echo.
echo  ==========================================
echo   BUILD COMPLETE
echo  ==========================================
echo.
echo  Standalone exe :  dist\HoodCC_JSON_Uploader.exe
if not %INNO_PATH%=="" (
echo  Windows installer:  installer_output\HoodCC_JSON_Uploader_Setup_v1.0.0.exe
)
echo.
echo  Users can install the setup .exe without Python, pip,
echo  or any technical knowledge.
echo.
pause