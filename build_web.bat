@echo off
setlocal enabledelayedexpansion

REM Title and Timestamp
echo.
echo ============================
echo   Flutter Web Build Script
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
echo [1/4] Cleaning Flutter build directory...
call flutter clean
if errorlevel 1 (
    echo Failed to clean. Exit code: %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

REM Getting dependencies
echo.
echo [2/4] Fetching dependencies...
call flutter pub get
if errorlevel 1 (
    echo Failed to get dependencies. Aborting.
    exit /b 1
)

REM Building APK
echo.
echo [3/4] Building Web application...
call flutter build web --base-href "/octo_search/" --release
if errorlevel 1 (
    echo Build failed. Check the logs.
    exit /b 1
)

REM Moving the build output to a specific directory
echo.
echo [4/4] Moving build output to web-release directory...
if exist "web-release" (
    rmdir /S /Q "web-release"
)
mkdir web-release
xcopy "build\web\*" "web-release\" /E /I /Y

echo.
echo ✅ Build completed successfully!
endlocal
pause
