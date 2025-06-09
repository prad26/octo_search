@echo off
setlocal enabledelayedexpansion

REM Title and Timestamp
echo.
echo ============================
echo   Flutter APK Build Script
echo ============================
echo Started at: %DATE% %TIME%
echo.

REM Check if Flutter is installed
where flutter >nul 2>&1
if errorlevel 1 (
    echo Flutter not found. Please make sure it's installed and in your PATH.
    exit /b 1
)

REM Cleaning build directory
echo [1/3] Cleaning Flutter build directory...
call flutter clean
if errorlevel 1 (
    echo Failed to clean. Exit code: %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Getting dependencies
echo.
echo [2/3] Fetching dependencies...
call flutter pub get
if errorlevel 1 (
    echo Failed to get dependencies. Aborting.
    exit /b 1
)

REM Building APK
echo.
echo [3/3] Building APK for each ABI...
call flutter build apk --split-per-abi --release
if errorlevel 1 (
    echo Build failed. Check the logs.
    exit /b 1
)

echo.
echo ✅ Build completed successfully!
echo APKs are located in: build\app\outputs\flutter-apk
endlocal
pause
